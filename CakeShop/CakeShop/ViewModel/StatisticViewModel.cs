using CakeShop.Model;
using LiveCharts;
using LiveCharts.Wpf;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CakeShop.ViewModel
{
    public class StatisticViewModel : BaseViewModel
    {
         
        public SeriesCollection PieSeriesCake { get; set; }
        public SeriesCollection ColumnSeriesRevenue { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public ICommand Refresh { get; set; }
       
        public List<StatisticCakeInfo> ListCakeInfo { get; set; }
        public List<StatisticCakeShop> ListCakeShop { get; set; }

      
        public class StatisticCakeInfo
        {
            public int Quantity { get; set; }
            public string CakeName { get; set; }
          
            public StatisticCakeInfo(string name, int quantity)
            {
                Quantity = quantity;
                CakeName = name;

            }
        }

        public class StatisticCakeShop
        {
            public string MonthYear { get; set; }
            public int Evenue { get; set; }
            public StatisticCakeShop(string monthYEar, int evenue)
            {
                MonthYear = monthYEar;
                Evenue = evenue;
            }
        }
        public StatisticViewModel()
        {
            StartDate = new DateTime(2020, 1, 1);
            EndDate = new DateTime(2020, 12, 31);
            DrawChart();
          
            Refresh = new RelayCommand<object>((p) =>
            {
                return true;
            }, (p) =>
            {
                DrawChart();

            });

        }

        public void DrawChart()
        {
            //Khoi tao 2 mang du lieu de ve bieu do
            ListCakeInfo = new List<StatisticCakeInfo>();
            ListCakeShop = new List<StatisticCakeShop>();


            //Kiểm tra giới hạn thống kê chỉ trong vòng 12 tháng
            if (EndDate.Year - StartDate.Year > 1 && EndDate.Month + (12 - StartDate.Month) + ((EndDate.Day > StartDate.Day) ? 1 : 0) > 12)
            {

                MessageBox.Show("Hệ thống chỉ có thể thống kê trong vòng 1 năm");
                return;
            }

            #region Lọc ra order và order chi tiết theo ngày thansg input
            //lọc ra những lượt mua có trong thời gian input
            var orders = DataProvider.Ins.DB.Orders.Where(
                x => x.OrderDate < EndDate && x.OrderDate > StartDate
                );

            //lấy thông tin chi tiết của những order đó cụ thể là mua những gì bao nhiêu vào ngày nào.
            var orderdetails = from o in orders
                               join d in DataProvider.Ins.DB.OrderDetails
                               on o.ID equals d.OrderID
                               select new
                               {
                                   CakeID = d.CakeID,
                                   Price = d.Price,
                                   Quantity = d.Quantity,
                                   OrderDate = o.OrderDate
                               };
            #endregion

            #region Biểu đồ tỉ lệ bánh bán ra
            // kêt và tạo bảng có ID Cake đã được mau trong khoảng thời gian input và số lượng được bán ra của chúng
            var cake_statistic = orderdetails.GroupBy(g => g.CakeID).Select(s => new
            {
                CakeID = s.Key,
                Quantity = s.Sum(a => a.Quantity)
            });

            //tạo bảng có tên đầy đủ và số lượng bán ra trong thời gian input
            var cake_statistic_withname = from s in cake_statistic
                                          join c in DataProvider.Ins.DB.Cakes
                                          on s.CakeID equals c.ID
                                          select new
                                          {
                                              CakeName = c.Name,
                                              Quatity = s.Quantity
                                          };


            PieSeriesCake = new SeriesCollection();

            //CakeName - Quantity
            foreach (var i in cake_statistic_withname)
            {
                PieSeriesCake.Add(
                        new PieSeries()
                        {
                            Title = i.CakeName,
                            DataLabels = true,
                            Values = new ChartValues<int>() { (int)i.Quatity }
                        }
                    );

            }
            #endregion

            #region Biểu đồ doanh thu theo tháng
            //Bieu do doanh thu theo thang

            if (StartDate.Year != EndDate.Year)
            {

                var odersByMonth_StartYear = orderdetails.Where(x => x.OrderDate.Value.Year == StartDate.Year).GroupBy(x => x.OrderDate.Value.Month).Select(s => new
                {
                    Month = s.Key,
                    Evenue = s.Sum(a => a.Price)
                });

                foreach (var i in odersByMonth_StartYear)
                {
                    ListCakeShop.Add(new StatisticCakeShop((i.Month.ToString() + "/" + StartDate.Year.ToString()), (int)i.Evenue));
                }

                var odersByMonth_EndYear = orderdetails.Where(x => x.OrderDate.Value.Year == EndDate.Year).GroupBy(x => x.OrderDate.Value.Month).Select(s => new
                {
                    Month = s.Key,
                    Evenue = s.Sum(a => a.Price)
                });

                foreach (var i in odersByMonth_EndYear)
                {
                    ListCakeShop.Add(new StatisticCakeShop((i.Month.ToString() + "/" + EndDate.Year.ToString()), (int)i.Evenue));
                }
            }
            else
            {
                var odersByMonth = orderdetails.GroupBy(x => x.OrderDate.Value.Month).Select(s => new
                {
                    Month = s.Key,
                    Evenue = s.Sum(a => a.Price)
                });

                foreach (var i in odersByMonth)
                {
                    ListCakeShop.Add(new StatisticCakeShop((i.Month.ToString() + "/" + EndDate.Year.ToString()), (int)i.Evenue));
                }

            }

            ColumnSeriesRevenue = new SeriesCollection();

            for (int i = 0; i < ListCakeShop.Count(); i++)
            {
                ColumnSeriesRevenue.Add(new ColumnSeries()
                {
                    Title = ListCakeShop.ElementAt(i).MonthYear,
                    DataLabels = true,
                    Values = new ChartValues<int>() { ListCakeShop.ElementAt(i).Evenue }
                });
            }

            #endregion
        }
    }
}
