using Microsoft.AspNetCore.Mvc;

namespace Himeji_WebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PunisherController : ControllerBase
    {
       

        private readonly ILogger<PunisherController> _logger;

        public PunisherController(ILogger<PunisherController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "Punisher")]
        public string Get()
        {
            return Himeji.Framework.Funny.Puns.GetJoke();
        }
    }
}