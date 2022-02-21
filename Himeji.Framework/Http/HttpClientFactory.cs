using System.Net.Http.Headers;
using System.Security.Authentication;
using System.Text;

namespace Himeji.Framework.Http
{
    public static class HttpClientFactory
    {
        public static HttpClient BasicAuth(string username, string password, bool useProxy = false, int timeoutSeconds = 0, 
            bool trustSelfSignedCerts = false)
        {
            var client = CreateClient(useProxy, timeoutSeconds, trustSelfSignedCerts);

            var byteArray = Encoding.ASCII.GetBytes($"{username}:{password}");
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            return client;
        }

        public static HttpClient TokenAuth(string token, bool useProxy = false, int timeoutSeconds = 0, 
            bool trustSelfSignedCerts = false, string proxyLocation = "")
        {
            var client = CreateClient(useProxy, timeoutSeconds, trustSelfSignedCerts, proxyLocation);

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            return client;
        }

        public static HttpClient NoAuth(bool useProxy = false, int timeoutSeconds = 0, bool trustSelfSignedCerts = false, 
            string proxyLocation = "")
        {
            return CreateClient(useProxy, timeoutSeconds, trustSelfSignedCerts, proxyLocation);
        }

        public static HttpClient PskAuth(string psk, bool useProxy = false, int timeoutSeconds = 0,
            bool trustSelfSignedCerts = false, string proxyLocation = "")
        {
            var client = CreateClient(useProxy, timeoutSeconds, trustSelfSignedCerts, proxyLocation);

            client.DefaultRequestHeaders.Add("psk", psk);

            return client;
        }

        private static HttpClient CreateClient(bool useProxy, int timeoutSeconds, bool trustSelfSignedCerts = false, 
            string proxyLocation = "")
        {
            var config = new HttpClientHandler();

            if (useProxy)
            {
                config.UseProxy = true;
                config.Proxy = new SomeProxy();
            }
            else
            {
                config.UseProxy = false;
            }

            if (trustSelfSignedCerts)
            {
                config.ClientCertificateOptions = ClientCertificateOption.Manual;
                config.ServerCertificateCustomValidationCallback = (httpRequestMessage, cert, cetChain, policyErrors) => true;
                config.SslProtocols = SslProtocols.Tls12 | SslProtocols.Tls11 | SslProtocols.Tls;
            }

            var client = new HttpClient(config);

            if (timeoutSeconds != 0)
            {
                client.Timeout = TimeSpan.FromSeconds(timeoutSeconds);
            }

            return client;
        }
    }
}
