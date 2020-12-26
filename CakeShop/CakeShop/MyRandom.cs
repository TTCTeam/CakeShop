using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CakeShop
{
    class MyRandom
    {
        private static MyRandom _instance = null;
        private Random rng;
        public static MyRandom Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new MyRandom();
                }
                return _instance;
            }
        }

        public int Next(int ceiling)
        {
            int value = rng.Next(ceiling);
            return value;
        }

        public MyRandom()
        {
            rng = new Random();
        }
    }
}
