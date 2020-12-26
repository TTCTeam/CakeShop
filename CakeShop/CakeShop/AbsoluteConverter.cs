using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace CakeShop
{
    class AbsoluteConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string path = (string)value;
            string absolute;
            if (isRelativePath(path))
            {
                var folder = AppDomain.CurrentDomain.BaseDirectory;
                absolute = $"{folder}{path}";
            }
            else
            {
                absolute = path;
            }
            return absolute;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
        static public bool isRelativePath(string imagePath)
        {
            return (imagePath.StartsWith("Images"));
        }
    }
}
