using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace CakeShop.ViewModel
{
    class MainWindowViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public int SwitchView { get; set; } = 0;

        public ICommand MinimizeCommand { get; set; }

        private int _SelectedIndex;

        public int SelectedIndex
        {
            get { return _SelectedIndex; }
            set { _SelectedIndex = value; SwitchView = SelectedIndex; }
        }


        public MainWindowViewModel()
        {
            MinimizeCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    
                });
        }
    }
}
