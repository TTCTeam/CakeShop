using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CakeShop.ViewModel
{
    class MainWindowViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public int SwitchView { get; set; } = 0;

        private int _SelectedIndex;
        public int SelectedIndex
        {
            get { return _SelectedIndex; }
            set { _SelectedIndex = value; SwitchView = SelectedIndex; }
        }

        public ICommand CloseWindowCommand { get; set; }
        public ICommand MaximizeWindowCommand { get; set; }
        public ICommand MinimizeWindowCommand { get; set; }
        public MainWindowViewModel()
        {
            CloseWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                var mess = MessageBox.Show("Do you want to exit ?", "Notification", MessageBoxButton.YesNo, MessageBoxImage.Question, MessageBoxResult.No);
                if (mess == MessageBoxResult.Yes)
                {
                    p.Close();
                }
            }
            );

            MaximizeWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                if (p.WindowState != WindowState.Maximized)
                    p.WindowState = WindowState.Maximized;
                else
                    p.WindowState = WindowState.Normal;
            }
            );

            MinimizeWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                p.WindowState = WindowState.Minimized;
            }
            );
        }
    }
}
