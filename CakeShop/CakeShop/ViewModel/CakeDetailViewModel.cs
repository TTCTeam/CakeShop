using CakeShop.Model;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CakeShop.ViewModel
{
    public class CakeDetailViewModel : BaseViewModel
    {


        public bool AddCakeState { get; set; } = false;
        public BindingList<string> TypeList { get; set; }
        public Cake Cake { get; set; }
        public string Type { get; set; }
        private string _ImagePath;
        public string ImagePath { get => _ImagePath; set { OnPropertyChanged(); _ImagePath = Cake.Thumbnail; } }
        public ICommand AddImageCommand { get; set; }
        public ICommand AddCommand { get; set; }
        public ICommand PreviousCakeCommand { get; set; }
        public ICommand NextCakeCommand { get; set; }
        public ICommand UpdateCommand { get; set; }
        public CakeDetailViewModel()
        {
            int CakeID; 

            using (CakeShopEntities db = new CakeShopEntities())
            {
                TypeList = new BindingList<string>();

                var typeList = db.TypeDescriptions.ToList();
                foreach (var item in typeList)
                {
                    TypeList.Add(item.Description);
                }
                if (SelectedItemClass.CakeId == null)
                {
                    Cake = new Cake();
                    ImagePath = Cake.Thumbnail;
                    AddCakeState = true;
                   
                }
                else
                {
                    CakeID = (int)SelectedItemClass.CakeId;
                    Cake = db.Cakes.Where(x => x.ID == CakeID).FirstOrDefault();
                    Type = db.TypeDescriptions.Where(x => x.Type == Cake.Type).FirstOrDefault().Description;
                    SelectedItemClass.CakeId = null;
                }

                CakeID = Cake.ID;
                //Cake = new Cake(1,"",0,"","");
                ImagePath = Cake.Thumbnail;
               
            }

            UpdateCommand = new RelayCommand<object>((p) =>
            {
                if (string.IsNullOrEmpty(Cake.Name) || string.IsNullOrEmpty(Cake.Ingredients) || string.IsNullOrEmpty(Cake.Price.ToString()) || string.IsNullOrEmpty(Cake.Description)||Cake.Thumbnail==null)
                {
                    return false;
                }
                if (Cake.Price < 0)
                {
                    return false;
                }
                if (AddCakeState) return false;


                return true;

            }, (p) =>
            {
                var cake = DataProvider.Ins.DB.Cakes.Where(x => x.ID == CakeID).SingleOrDefault();
                string oldPath = cake.Thumbnail;
                cake.Thumbnail = ImagePath;

                cake.Name = Cake.Name;
                cake.Price = Cake.Price;
                cake.Ingredients = Cake.Ingredients;
                cake.Description = Cake.Description;

                var type = DataProvider.Ins.DB.TypeDescriptions.Where(x => x.Description == Type).SingleOrDefault().Type;
                cake.Type = type;

                DataProvider.Ins.DB.SaveChanges();
                //Delete the old file
                //if (File.Exists(oldPath))
                //{
                //    File.Delete(oldPath);
                //}
                MessageBox.Show("Đã cập nhật thành công.");
            });

            AddImageCommand = new RelayCommand<object>((p) =>
            {
                return true;
            }, (p) =>
             {
                 var openFileDialog = new OpenFileDialog();
                 openFileDialog.Multiselect = true;
                 openFileDialog.Filter = "Image files (*.jpg, *.jpeg, *.jpe, *.png) | *.jpg; *.jpeg; *.jpe; *.png";

                 if (openFileDialog.ShowDialog() == true)
                 {
                     var files = openFileDialog.FileNames;

                     foreach (var file in files)
                     {
                         ImagePath = file;
                         OnPropertyChanged();
                         SaveImageToFolder(Cake, ImagePath);
                         break;
                     }


                 }
             });

            NextCakeCommand = new RelayCommand<object>((p) =>
            {
                if (AddCakeState) return false;
                if (Cake.ID >= DataProvider.Ins.DB.Cakes.Max(c=>c.ID))
                {
                    return false;
                }
                return true;
            }, (p) =>
            {

                int ID = Cake.ID;

                Cake cake;
                do
                {
                    ID++;

                    cake = DataProvider.Ins.DB.Cakes.Find(ID);
                } while (cake == null);

                if (cake != null)
                {
                    Cake = cake;
                    ImagePath = cake.Thumbnail;
                }
                

                OnPropertyChanged();
            });
            PreviousCakeCommand = new RelayCommand<object>((p) =>
            {
                if (AddCakeState) return false;
                if (Cake.ID <= DataProvider.Ins.DB.Cakes.Min(c => c.ID))
                {
                    return false;
                }
                return true;
            }, (p) =>
            {
                int ID = Cake.ID;

                Cake cake;
                do
                {
                    ID--;

                    cake = DataProvider.Ins.DB.Cakes.Find(ID);
                } while (cake == null);

                if (cake != null)
                {
                    Cake = cake;
                    ImagePath = cake.Thumbnail;
                }
                OnPropertyChanged();
            });

            //AddCommand = new RelayCommand<object>((p) =>
            //{
            //    if (string.IsNullOrEmpty(Cake.Name) || string.IsNullOrEmpty(Cake.Ingredients) || string.IsNullOrEmpty(Cake.Price.ToString()) || string.IsNullOrEmpty(Cake.Description) || Cake.Thumbnail == null)
            //    {
            //        return false;
            //    }
            //    if (Cake.Price < 0)
            //    {
            //        return false;
            //    }
            //    return true;
            //}, (p) =>
            //{
            //    if (AddCakeState == false)
            //    {
            //        var mess = MessageBox.Show("Add new Cake ?", "Notification", MessageBoxButton.YesNo, MessageBoxImage.Question, MessageBoxResult.No);
            //        if (mess == MessageBoxResult.No)
            //        {
            //            return;
            //        }
            //        Cake = new Cake();
            //        ImagePath = Cake.Thumbnail;
            //        AddCakeState = true;
            //    }
            //    else
            //    {
            //        DataProvider.Ins.DB.Cakes.Add(Cake);
            //        DataProvider.Ins.DB.SaveChanges();
            //    }

            //    OnPropertyChanged();

            //});



        }
    
        public void SaveImageToFolder(Cake cake, string newFilePath)
        {
            // Create Folder
            var currentFolder = AppDomain.CurrentDomain.BaseDirectory;
            var directoryPath = $"{currentFolder}Images";
            if (!System.IO.Directory.Exists(directoryPath))
                System.IO.Directory.CreateDirectory(directoryPath);

            //copy to Images folder and write to data

            if (!AbsoluteConverter.isRelativePath(newFilePath))
            {
                var inFo = new FileInfo(newFilePath);
                var newname = $"{Guid.NewGuid()}{inFo.Extension}";
                File.Copy(newFilePath, $"{directoryPath}\\{newname}");
                ImagePath = ConvertAbsolutePathToRelativePath($"{directoryPath}\\{newname}");
            }

        }

        private string ConvertAbsolutePathToRelativePath(string absolutePath)
        {
            string relativePath;
            int temp = absolutePath.LastIndexOf("Images");
            relativePath = absolutePath.Substring(temp);
            return relativePath;
        }
    }
}
