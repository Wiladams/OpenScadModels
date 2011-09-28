using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;

namespace ImageConvert
{
    class Program
    {
        static void Main(string[] args)
        {
            Bitmap bmap = (Bitmap)Bitmap.FromFile(args[0]);

            string name = args[0].Remove(args[0].LastIndexOf('.'));
            WriteBitmap(bmap, name);
        }

        static string getColorString(Color col)
        {
            string retValue = string.Format("{0},{1},{2}  ",
                col.R, col.G, col.B);

            return retValue;
        }

        static void WriteBitmap(Bitmap bmap, string name)
        {
            Console.WriteLine("{0}_values = [", name);
            for (int y = 0; y < bmap.Height; y++)
            {
                for (int x = 0; x < bmap.Width; x++)
                {
                    Color col = bmap.GetPixel(x, y);
                    Console.Write("{0},", getColorString(col));
                }
                Console.WriteLine();    // finish out the line
            }
            Console.WriteLine("];");

            // Finish out the image construction
            Console.WriteLine("{0} = image(width={1}, height={2}, maxvalue=255, values = {0}_values, cpe=3);",
                name, bmap.Width, bmap.Height);
        }
    }
}
