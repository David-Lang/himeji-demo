using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace Himeji_WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SlackMessageController : ControllerBase
    {
       
        private readonly ILogger<SlackMessageController> _logger;

        public SlackMessageController(ILogger<SlackMessageController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "SlackMessage")]
        public string Get()
        {
            var result = "";
            var details = new StringBuilder();

            var hostName = Environment.GetEnvironmentVariable("HOSTNAME");
            if (string.IsNullOrEmpty(hostName)) hostName = "Unable to read environment variable HOSTNAME";
            details.AppendLine($"Running on: {hostName}");

            var appVersion = Environment.GetEnvironmentVariable("HIMEJI_APP_VERSION");
            if (string.IsNullOrEmpty(appVersion)) appVersion = "Unable to read environment variable HIMEJI_APP_VERSION";
            details.AppendLine($"AppVersion: {appVersion}");

            var helmRelease = Environment.GetEnvironmentVariable("HIMEJI_HELM_RELEASE");
            if (string.IsNullOrEmpty(helmRelease)) helmRelease = "Unable to read environment variable HIMEJI_HELM_RELEASE";
            details.AppendLine($"HelmRelease: {helmRelease}");

            var awesomeJoke = Himeji.Framework.Funny.Puns.GetJoke();
            var msg = $"{awesomeJoke} ```{details.ToString()}```";
            
            result = msg;

            try 
            {
                Himeji.Framework.Slack.Api.WebHookBotDuty.SendMessage(msg, "C033X1MLJDT");
            }
            catch (Exception ex) 
            {
                result = ex.ToString();
            }   

            return msg;
        }
    }
}