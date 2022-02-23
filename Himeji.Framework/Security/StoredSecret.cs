using System;

namespace Himeji.Framework.Security
{
    public class StoredSecret
    {
        #region Properties
        
        public string SecretName { get; set; }
        public string SecretValue { get; set; }

        #endregion

        #region LifeTime Events

        public StoredSecret()
        {
            
        }

        public StoredSecret(string secretName, string secretValue) 
        {
            SecretName = secretName;
            SecretValue = secretValue;
        }

        #endregion

        #region Methods

        public static StoredSecret GetBotDutySecret()
        { 
        
            var secretValue = Environment.GetEnvironmentVariable("SLACK_BOTDUTY_WEBHOOK");
            if (secretValue == null)
            {
                System.Console.WriteLine($"Unable to get Environment Variable 'SLACK_BOTDUTY_WEBHOOK'");
                secretValue = "";
            }

            var credentials = new StoredSecret()
            {
                SecretName = "BotDutyWebHook",
                SecretValue = secretValue,
            };
            return credentials;

        }

        #endregion

    }
}
