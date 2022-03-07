
namespace Himeji.Framework.Funny
{
    public static class Puns
    {

        private static readonly string[] _dadJokes = new[]
        {
            "How did Darth Vader know what Luke got him for Christmas? He felt his presents!",
            "I wanted to go on a diet, but I feel like I have way too much on my plate right now.",
            "Want to hear a joke about construction? I'm still working on it.",
            "What sound does a witches car make? Broom Broom",
            "To whoever stole my copy of Microsoft Office, I will find you. You have my Word!",
            "What does a zombie vegetarian eat? 'GRRRAAAIINS!'",
            "This graveyard looks overcrowded. People must be dying to get in there.",
            "I tell dad jokes, but I don't have any kids. I'm a faux pa.",
            "Two goldfish are in a tank. One says to the other, 'do you know how to drive this thing?'",
            "What’s that Nevada city where all the dentists visit? Floss Vegas.",
            "Why did the picture go to jail? Because it was framed.",
            "What do you call a bear without any teeth? A gummy bear!",
            "The shovel was a ground-breaking invention.",
            "5/4 of people admit that they’re bad with fractions.",
            "What do you call a man with a rubber toe? Roberto.",
            "I would avoid the sushi if I was you. It’s a little fishy.",
            "What do you call a fish with two knees? A two-knee fish!",
            "The rotation of earth really makes my day.",
            "I thought about going on an all-almond diet. But that's just nuts.",
            "Did you know the first French fries weren't actually cooked in France? They were cooked in Greece.",
            "What's black and white and goes around and around? A penguin in a revolving door.",
        };

        public static string GetJoke() 
        {
            return _dadJokes[Random.Shared.Next(_dadJokes.Length)];
        }
    }
}