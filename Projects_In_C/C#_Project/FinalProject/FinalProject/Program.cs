using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject
{
    class Program
    {
        static void Main(string[] args)
        {
            int temp = 98;
            int index = 0;
            Random maintainence = new Random();//the maintainence crew
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool A = new Pool(new Location(4, 8), new Temperature(temp, "F"), false, "A");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool B = new Pool(new Location(1, 3), new Temperature(temp, "F"), false, "B");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool C = new Pool(new Location(4, 2), new Temperature(temp, "F"), false, "C");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool D = new Pool(new Location(13, 1), new Temperature(temp, "F"), false, "D");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool E = new Pool(new Location(12, 9), new Temperature(temp, "F"), false, "E");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool F = new Pool(new Location(10, 5), new Temperature(temp, "F"), false, "F");
            Console.WriteLine("The pool count is currently {0}", Pool.count);
            Pool G = new Pool(new Location(6, 6), new Temperature(temp, "F"), false, "G");
            Console.WriteLine("The pool count is currently {0}\n\n\n", Pool.count);
            ////////////////////////////////////////////////////////////////////////////////////
            Pool[] community = { A, B, C, D, E, F, G };//a community of pools
            int a = 0, b = 0; 
            while (Utilities.GetClosestPool(community, a, b) != -1)
            {
                index = Utilities.GetClosestPool(community, a, b);
                Console.WriteLine(community[index]);
                community[index].Temp.Degree = (maintainence.Next(98, 105));
                community[index].Maintained = true;
                Console.WriteLine("After maintainence:\n\n" + community[index] + "\n\n\nNEXT POOL:\n\n\n");
                a = community[index].Loc.X;
                b = community[index].Loc.Y;
            }//Keep finding the next closest pool to maintain until all pools are maintained 

            Console.WriteLine(Utilities.GetClosestPool(community, 0, 0));//should return -1 since all pools are maintained
            Console.Read();
        }
    }
}
