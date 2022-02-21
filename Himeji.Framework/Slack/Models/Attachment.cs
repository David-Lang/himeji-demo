using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;

namespace Himeji.Framework.Slack.Models
{
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    [SuppressMessage("ReSharper", "IdentifierTypo")]
    [SuppressMessage("ReSharper", "UnusedMember.Global")]
    public class Attachment
    {
        public string Title { get; set; }
        public string Title_Link { get; set; }
        public string Fallback { get; set; }
        public string Pretext { get; set; }
        public string Text { get; set; }
        public string Color { get; set; }
        public Field[] Fields { get; set; }
        public string Callback_id { get; set; }
        public string Attachment_type { get; set; }
        public Action[] Actions { get; set; }
        public string Image_url { get; set; }
        public List<string> Mrkdwn_in { get; set; }
    }
}