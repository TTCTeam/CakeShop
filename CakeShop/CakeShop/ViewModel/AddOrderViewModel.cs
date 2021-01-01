using CakeShop.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Windows.Media;

namespace CakeShop.ViewModel
{
    class AddOrderViewModel : BaseViewModel
    {
        private int paymentMethod;
        private Cake selectedCake;

        public string CustomerName { get; set; }
        public string Tel { get; set; }
        public string Address { get; set; }
        public DateTime? OrderDate { get; set; }
        public int PaymentMethod { get => paymentMethod; set => paymentMethod = value; }
        public bool PaymentInCash
        {
            get { return paymentMethod == 0; }
            set { if (value) paymentMethod = 0; }
        }
        public bool PaymentByBankTransfer
        {
            get { return paymentMethod == 1; }
            set { if (value) paymentMethod = 1; }
        }

        public List<Cake> Cakes { get; set; }
        public int? Price { get => price; set => price = value; }
        public int[] Quantities { get; set; } = { 1, 2, 3, 4, 5 };

        public ObservableCollection<OrderDetail> OrderDetails { get; set; }

        public Cake SelectedCake 
        { 
            get => selectedCake;
            set 
            {
                selectedCake = value;
                if (value != null)
                {
                    Price = value.Price;
                }
                else
                {
                    Price = null;
                }
            } 
        }
        private int? seletedQuantity;
        private int? price;

        public int Total { get; set; } = 0;

        public int? SelectedQuantity
        {
            get { return seletedQuantity; }
            set { seletedQuantity = value; }
        }

        public SolidColorBrush TotalColor { get; set; } = Brushes.Red;

        private bool isPaied = false;

        public bool IsPaied
        {
            get { return isPaied; }
            set 
            {
                isPaied = value;
                TotalColor = value ? Brushes.DarkGreen : Brushes.Red;
            }
        }



        public ICommand AddOrderDetailCommand { get; set; }
        public ICommand RemoveOrderDetailCommand { get; set; }
        public ICommand PropertyChangedCommand { get; set; }
        public ICommand AddOrderCommand { get; set; }

        public AddOrderViewModel()
        {
            Cakes = DataProvider.Ins.DB.Cakes.ToList();
            OrderDetails = new ObservableCollection<OrderDetail>();

            if (SelectedItemClass.OrderId!=null)
            {
                var order = DataProvider.Ins.DB.Orders.Find(SelectedItemClass.OrderId);
                CustomerName = order.Customer.Name;
                Tel = order.Customer.Tel;
                Address = order.Customer.Address;
                OrderDate = order.OrderDate;
                PaymentMethod = (int)order.PaymentMethod;
                OrderDetails = order.OrderDetails;
                IsPaied = (bool)order.IsPaied;
                CalculateTotal();
                SelectedItemClass.OrderId = null;
            }

            AddOrderDetailCommand = new RelayCommand<object>((p) =>
            {
                return SelectedCake != null && SelectedQuantity != null;
            },
                (p) =>
                {
                    OrderDetail orderDetail = new OrderDetail { Cake = SelectedCake, Price = Price, Quantity = (int)SelectedQuantity };
                    OrderDetails.Add(orderDetail);
                    SelectedCake = null;
                    SelectedQuantity = null;
                    CalculateTotal();
                });

            RemoveOrderDetailCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    OrderDetail order = p as OrderDetail;
                    OrderDetails.Remove(order);
                    CalculateTotal();
                });

            PropertyChangedCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    CalculateTotal();
                });

            AddOrderCommand= new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    Customer customer = new Customer { Name = CustomerName, Tel = Tel, Address = Address };
                    Order order = new Order { Customer = customer, OrderDate = OrderDate, PaymentMethod = PaymentMethod, OrderDetails = OrderDetails, IsPaied = IsPaied };
                    var db = DataProvider.Ins.DB;
                    db.Orders.Add(order);
                    db.SaveChanges();
                });
        }

        private void CalculateTotal()
        {
            Total = 0;
            foreach (var item in OrderDetails)
            {
                Total += (int)item.Price*(int)item.Quantity;
            }
        }
    }
}
