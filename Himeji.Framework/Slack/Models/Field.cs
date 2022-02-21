using System.Diagnostics.CodeAnalysis;

namespace Himeji.Framework.Slack.Models
{
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    [SuppressMessage("ReSharper", "IdentifierTypo")]
    [SuppressMessage("ReSharper", "UnusedMember.Global")]
    public class Field
    {
        public string Title { get; set; }
        public string Value { get; set; }
        public bool @Short { get; set; }
    }
}