using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace Himeji_WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class About : ControllerBase
    {
       
        private readonly ILogger<WeatherForecastController> _logger;

        public About(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "About")]
        public string Get()
        {
            var result = new StringBuilder();
            var podName = Environment.GetEnvironmentVariable("HOSTNAME");
            if (string.IsNullOrEmpty(podName)) podName = "Unable to read HOSTNAME";
            result.AppendLine($"Running on: {podName}");

            return result.ToString();
        }
    }
}