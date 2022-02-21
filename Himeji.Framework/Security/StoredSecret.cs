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
        
            var secretValue = Environment.GetEnvironmentVariable("BotDutyWebHook");
            if (secretValue == null)
            {
                System.Console.WriteLine($"Unable to get Environment Variable 'BotDutyWebHook'");
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
