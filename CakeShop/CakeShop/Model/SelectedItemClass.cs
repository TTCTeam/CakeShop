﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CakeShop.Model
{
    class SelectedItemClass
    {
        public static int? CakeId { get; set; } = null;
        public static int? OrderId { get; set; } = null;
        public static bool SelectedClick { get; set; } = false;
    }
}
