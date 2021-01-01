using CakeShop.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace CakeShop.ViewModel
{
    class ListOrdersModelView:BaseViewModel
    {
        public List<Order> Orders { get; set; }

        public ICommand ShowDetailOrderCommand { get; set; }

        public ListOrdersModelView()
        {
            Orders = DataProvider.Ins.DB.Orders.ToList();

            ShowDetailOrderCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    SelectedItemClass.OrderId = (p as Order).ID;
                    MainWindowViewModel.Instance.SelectedIndex = -2;
                });
        }
    }
}
