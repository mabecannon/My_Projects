using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject
{
    class Temperature
    {
        private String scale;
        private int degree;

        public String Scale
        {
            get { return scale; }
            set { scale = value; }
        }
            
        public int Degree
        {
            get { return degree; }
            set { degree = value; }
        }

        public Temperature()
        {
            Scale = "K";
            Degree = 0;
        }

        public Temperature(int t, String s)
        {
            Degree = t;
            Scale = s;
        }

        public override string ToString()
        {
            return Degree + "°" + Scale + "\n";
        }
    }
}
