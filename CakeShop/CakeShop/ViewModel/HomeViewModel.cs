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
    class HomeViewModel : BaseViewModel
    {
        string searchString = "";
        TypeDescription selectedType;
        int totalProducts = 0;
        int totalPages = 0;
        int rowsPerPage = 10;
        int currentPage = 1;

        private ObservableCollection<Cake> _List;
        public ObservableCollection<Cake> List { get => _List; set { _List = value; OnPropertyChanged(); } }

        private ObservableCollection<TypeDescription> _ListType;
        public ObservableCollection<TypeDescription> ListType { get => _ListType; set { _ListType = value; OnPropertyChanged(); } }

        private Cake _SelectedItem;
        public Cake SelectedItem
        {
            get => _SelectedItem;
            set
            {
                _SelectedItem = value;
                OnPropertyChanged();
                if (SelectedItem != null)
                {
                    SearchName = SelectedItem.Name;
                }
            }
        }

        private string _SearchName;
        public string SearchName { get => _SearchName; set { _SearchName = value; OnPropertyChanged(); } }

        private string _CurrentPagePerTotalPage;
        public string CurrentPagePerTotalPage { get { return _CurrentPagePerTotalPage; } set { _CurrentPagePerTotalPage = value; OnPropertyChanged(); } }

        private string _Tittle;
        public string Tittle { get { return _Tittle; } set { _Tittle = value; OnPropertyChanged(); } }

        private int _SelectedTypeIndex;
        public int SelectedTypeIndex { get { return _SelectedTypeIndex; } set { _SelectedTypeIndex = value; OnPropertyChanged(); } }

        private TypeDescription _SelectedType;
        public TypeDescription SelectedType
        {
            get { return _SelectedType; }
            set
            {
                currentPage = 1;
                SearchName = "";
                _SelectedType = value;
                OnPropertyChanged();
                selectedType = SelectedType;
                Tittle = selectedType.Description.ToUpper();
                displayCakeList();
            }
        }

        public ICommand SearchCommand { get; set; }
        public ICommand FirstPageCommand { get; set; }
        public ICommand PreviousPageCommand { get; set; }
        public ICommand NextPageCommand { get; set; }
        public ICommand LastPageCommand { get; set; }

        public HomeViewModel()
        {
            Tittle = "DANH SÁCH BÁNH";
            SelectedTypeIndex = 0;
            // Danh sách tất cả các type
            var listtype = from p in DataProvider.Ins.DB.TypeDescriptions
                           select p;
            ListType = new ObservableCollection<TypeDescription>(listtype.Distinct().ToList());
            TypeDescription xyz = new TypeDescription { Type = 0, Description = "Tất cả" };
            ListType.Insert(0, xyz);

            displayCakeList();

            SearchCommand = new RelayCommand<object>((p) =>
                {
                    return true;
                },
                (p) =>
                {
                    currentPage = 1;
                    selectedType = null;
                    searchString = SearchName;
                    SelectedTypeIndex = 0;
                    Tittle = "DANH SÁCH BÁNH";
                    displayCakeList();
                });

            FirstPageCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    currentPage = 1;
                    displayCakeList();
                });

            PreviousPageCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    if ((currentPage > 1) && (currentPage <= totalPages))
                    {
                        currentPage--;
                        displayCakeList();
                    }
                });

            NextPageCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    if ((currentPage > 0) && (currentPage < totalPages))
                    {
                        currentPage++;
                        displayCakeList();
                    }
                });

            LastPageCommand = new RelayCommand<object>((p) =>
            {
                return true;
            },
                (p) =>
                {
                    currentPage = totalPages;
                    displayCakeList();
                });
        }

        void displayCakeList()
        {
            if ((SelectedTypeIndex == 0) || (selectedType == null))
            {
                Tittle = "DANH SÁCH BÁNH";
                var query = from p in DataProvider.Ins.DB.Cakes
                            where p.Name.Contains(searchString)
                            orderby p.Name
                            select p;

                totalProducts = query.Count();

                var skip = (currentPage - 1) * rowsPerPage;
                var take = rowsPerPage;
                totalPages = totalProducts / rowsPerPage +
                    (((totalProducts % rowsPerPage) == 0) ? 0 : 1);

                CurrentPagePerTotalPage = $"{currentPage} / {totalPages}";

                List = new ObservableCollection<Cake>(query.Skip(skip).Take(take).ToList());
            }
            else
            {
                var query = from p in selectedType.Cakes
                            select p;
                totalProducts = query.Count();

                var skip = (currentPage - 1) * rowsPerPage;
                var take = rowsPerPage;
                totalPages = totalProducts / rowsPerPage +
                    (((totalProducts % rowsPerPage) == 0) ? 0 : 1);

                CurrentPagePerTotalPage = $"{currentPage} / {totalPages}";

                List = new ObservableCollection<Cake>(query.Skip(skip).Take(take).ToList());
            }
        }
    }
}
