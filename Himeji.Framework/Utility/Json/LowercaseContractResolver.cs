using Newtonsoft.Json.Serialization;

namespace Himeji.Framework.Utility.Json
{
    public class LowercaseContractResolver : DefaultContractResolver
    {
        protected override string ResolvePropertyName(string propertyName)
        {
            return propertyName.ToLower();
        }
    }
}