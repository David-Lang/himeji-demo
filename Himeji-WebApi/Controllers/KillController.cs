using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace Himeji_WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KillController : ControllerBase
    {
       
        private readonly ILogger<KillController> _logger;

        public KillController(ILogger<KillController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "Kill")]
        public string Get()
        {
            Environment.Exit(1);

            return string.Empty;
        }
    }
}