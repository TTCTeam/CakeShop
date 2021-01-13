using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace CakeShop
{
    /// <summary>
    /// Interaction logic for SplashScreen.xaml
    /// </summary>
    public partial class SplashScreen : Window
    {

        class Splashscreen
        {
            public string Image { get; set; }
            public string Title { get; set; }
            public string Overview { get; set; }


        }
        const string Slash = "/";
        class SplashScreenDAO
        {

            public static Splashscreen getAll()
            {
                var filepath = $"SplashScreen.txt";

                var splscreen = new Splashscreen();

                int range = lineFile(filepath);

                int index = MyRandom.Instance.Next(range);

                using (var reader = new StreamReader(filepath))
                {
                    var line = "";
                    for (int i = 0; i <= index; i++)
                    {
                        line = reader.ReadLine();
                    }


                    string[] tokens = line.Split(new string[] { Slash }, StringSplitOptions.RemoveEmptyEntries);

                    splscreen.Image = $"Images/SplashScreen/{tokens[0]}";
                    splscreen.Title = tokens[1];
                    splscreen.Overview = tokens[2];
                }
                return splscreen;

            }

            private static int lineFile(string filepath)
            {
                int lines = 0;

                using (var reader = new StreamReader(filepath))
                {
                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();
                        lines++;
                    }
                }

                return lines;
            }
        }



        public int count = 0;
        public int target = 1000;

        public System.Timers.Timer _timer;

        public SplashScreen()
        {
            InitializeComponent();

            _timer = new System.Timers.Timer(1);
            _timer.Elapsed += UpdateValueProgressBar;
            _timer.Start();

            this.Start.Visibility = Visibility.Hidden;

           
            var value = ConfigurationManager.AppSettings["DontShowSplashScreen"];
            var dontShowSplashScreen = bool.Parse(value);

            if (dontShowSplashScreen)
            {
                var screen = new MainWindow();
                screen.Show();

                if (_timer != null)
                {
                    this._timer.Stop();
                }
                this.Close();
            }
        }

        private void UpdateValueProgressBar(object sender, ElapsedEventArgs e)
        {
            count += 2;
            double per = count * 100.0 / target;
            string result = string.Format("{0:0.0}%", per);


            Dispatcher.Invoke(() =>
            {
                if (count == target)
                {
                    _timer.Stop();

                    percent.Text = result;
                    this.Start.Visibility = Visibility.Visible;

                    //... main screen display
                }

                percent.Text = result;
                progressBar.Value = count;
            });
        }

        private void Start_Click(object sender, RoutedEventArgs e)
        {
            var config = ConfigurationManager.OpenExeConfiguration(
            ConfigurationUserLevel.None);

            if (checkShow.IsChecked == true)
            {

                config.AppSettings.Settings["DontShowSplashScreen"].Value = "true";

            }
            else
            {
                config.AppSettings.Settings["DontShowSplashScreen"].Value = "false";

            }

            config.Save(ConfigurationSaveMode.Minimal);

            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            DataContext = SplashScreenDAO.getAll();
        }
    }
}
