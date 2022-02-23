using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace Himeji_WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AboutController : ControllerBase
    {
       
        private readonly ILogger<AboutController> _logger;

        public AboutController(ILogger<AboutController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "About")]
        public string Get()
        {
            var result = new StringBuilder();

            var hostName = Environment.GetEnvironmentVariable("HOSTNAME");
            if (string.IsNullOrEmpty(hostName)) hostName = "Unable to read environment variable HOSTNAME";
            result.AppendLine($"Running on: {hostName}");

            var appVersion = Environment.GetEnvironmentVariable("HIMEJI_APP_VERSION");
            if (string.IsNullOrEmpty(appVersion)) appVersion = "Unable to read environment variable HIMEJI_APP_VERSION";
            result.AppendLine($"AppVersion: {appVersion}");

            var helmRelease = Environment.GetEnvironmentVariable("HIMEJI_HELM_RELEASE");
            if (string.IsNullOrEmpty(helmRelease)) helmRelease = "Unable to read environment variable HIMEJI_HELM_RELEASE";
            result.AppendLine($"HelmRelease: {helmRelease}");

            return result.ToString();
        }
    }
}