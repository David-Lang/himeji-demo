using Himeji.Framework.Http;
using Himeji.Framework.Security;
using Himeji.Framework.Slack.Models;
using Newtonsoft.Json;
using System.Text;
using Himeji.Framework.Utility.Json;


namespace Himeji.Framework.Slack.Api
{
    public static class WebHookBotDuty
    {
        private static readonly StoredSecret Credentials;

        private static Uri _webhookUrl;
        private static string _channel;
        private static HttpClient _httpClient;

        static WebHookBotDuty()
        {
            Credentials = StoredSecret.GetBotDutySecret();

            _webhookUrl = new Uri($@"https://hooks.slack.com/services/{Credentials.SecretValue}");

            _channel = "C033KB1LXAB";

            _httpClient = HttpClientFactory.NoAuth(false, 2);
        }

        public static void SendMessage(string message, string channel = "C033KB1LXAB")
        {
            var response = SendMessageAsync(message, _channel);

            try
            {
                response.Wait();

                if (!response.Result.IsSuccessStatusCode)
                {
                    var msg = $"Non-success status code: {(int)response.Result.StatusCode} received from {_webhookUrl.AbsolutePath}";
                    throw new ArgumentException(msg);
                }

                var body = response.Result.Content.ReadAsStringAsync();

                return;
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.ToString());
                throw;
            }
        }

        private static async Task<HttpResponseMessage> SendMessageAsync(string message, string channel = null, Attachment[] attachments = null, string senderUserName = null)
        {
            Payload payload = new Payload()
            {
                Text = message,
                Channel = channel,
                Username = senderUserName,
                Attachments = attachments
            };
            return await SendPayloadAsync(payload);
        }

        private static async Task<HttpResponseMessage> SendPayloadAsync(Payload payload)
        {
            var settings = new JsonSerializerSettings { ContractResolver = new LowercaseContractResolver() };
            var serializedPayload = JsonConvert.SerializeObject(payload, Formatting.None, settings);
            var response = await _httpClient.PostAsync(_webhookUrl, new StringContent(serializedPayload, Encoding.UTF8, "application/json"));
            return response;
        }


    }
}
