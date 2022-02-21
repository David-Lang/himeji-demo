using System;
using System.Net;

namespace Himeji.Framework.Http
{
    public class SomeProxy : IWebProxy
    {

        public SomeProxy()
        {
            ProxyUri = new Uri(@"http://domain:8083/");
        }

        public Uri ProxyUri { get; set; }

        public ICredentials Credentials { get; set; }

        public Uri GetProxy(Uri destination)
        {
            return ProxyUri;
        }

        public bool IsBypassed(Uri host)
        {
            //you can proxy all requests or implement bypass urls based on config settings
            return false;
        }
    }
}