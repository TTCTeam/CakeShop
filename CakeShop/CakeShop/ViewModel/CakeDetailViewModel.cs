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
        public BindingList<string> TypeList { get; set; }
        public Cake Cake { get; set; }
        public string Type { get; set; }
        public string ImagePath { get; set; }
        public ICommand AddImageCommand { get; set; }
        public ICommand UpdateCommand { get; set; }
        public CakeDetailViewModel()
        {
            int CakeID = 2;

            using (CakeShopEntities db = new CakeShopEntities())
            {
                TypeList = new BindingList<string>();

                var typeList = db.TypeDescriptions.ToList();
                foreach (var item in typeList)
                {
                    TypeList.Add(item.Description);
                }

                Cake = db.Cakes.Where(x => x.ID == CakeID).FirstOrDefault();
                //Cake = new Cake(1,"",0,"","");
                ImagePath = Cake.Thumbnail;
                Type = db.TypeDescriptions.Where(x => x.Type == Cake.Type).FirstOrDefault().Description;
            }

            UpdateCommand = new RelayCommand<object>((p) =>
            {
                if (string.IsNullOrEmpty(Cake.Name) || string.IsNullOrEmpty(Cake.Ingredients) || string.IsNullOrEmpty(Cake.Price.ToString()) || string.IsNullOrEmpty(Cake.Description))
                {
                    return false;
                }
                if (Cake.Price < 0)
                {
                    return false;
                }


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

        }
        public CakeDetailViewModel(int CakeID)
        {
            CakeID = 2;

            using (CakeShopEntities db = new CakeShopEntities())
            {
                TypeList = new BindingList<string>();

                var typeList = db.TypeDescriptions.ToList();
                foreach (var item in typeList)
                {
                    TypeList.Add(item.Description);
                }

                Cake = db.Cakes.Where(x => x.ID == CakeID).FirstOrDefault();
                //Cake = new Cake(1,"",0,"","");
                ImagePath = Cake.Thumbnail;
                Type = db.TypeDescriptions.Where(x => x.Type == Cake.Type).FirstOrDefault().Description;
            }

            UpdateCommand = new RelayCommand<object>((p) =>
            {
                return false;

            }, (p) =>
            {
                //var cake = DataProvider.Ins.DB.Cakes.Where(x => x.ID == CakeID).SingleOrDefault();
                //cake.Name = Cake.Name;
                //cake.Price = Cake.Price;
                //cake.Ingredients = Cake.Ingredients;
                //cake.Description = Cake.Description;
                //var type = DataProvider.Ins.DB.TypeDescriptions.Where(x => x.Description == Type).SingleOrDefault().Type;
                //cake.Type = type;
                //DataProvider.Ins.DB.SaveChanges();
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
                        break;
                    }

                }
            });
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
