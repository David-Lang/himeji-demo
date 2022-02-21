using System.Diagnostics.CodeAnalysis;

namespace Himeji.Framework.Slack.Models
{
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    [SuppressMessage("ReSharper", "IdentifierTypo")]
    [SuppressMessage("ReSharper", "UnusedMember.Global")]
    public class Payload
    {
        public string Text { get; set; }
        public string Channel { get; set; }
        public string Username { get; set; }
        public Attachment[] Attachments { get; set; }
        public bool Link_names { get; set; } = true;
        public bool Parse { get; set; }
    }
}