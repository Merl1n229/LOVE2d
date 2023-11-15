using System;
using System.IO;

class Program
{
    static void Main()
    {
        string[] input = File.ReadAllLines("input2.txt");
        int n = int.Parse(input[0]);
        int[,] sudoku = new int[n * n, n * n];

        for (int i = 1; i <= n * n; i++)
        {
            string[] row = input[i].Split();
            for (int j = 0; j < n * n; j++)
            {
                sudoku[i - 1, j] = int.Parse(row[j]);
            }
        }

        if (IsSudokuCorrect(sudoku, n))
        {
            File.WriteAllText("output2.txt", "Correct");
        }
        else
        {
            File.WriteAllText("output2.txt", "Incorrect");
        }
    }

    static bool IsSudokuCorrect(int[,] sudoku, int n)
    {
        int size = n * n;

        for (int i = 0; i < size; i++)
        {
            bool[] rowCheck = new bool[size];
            bool[] colCheck = new bool[size];

            for (int j = 0; j < size; j++)
            {
                int rowIndex = sudoku[i, j] - 1;
                int colIndex = sudoku[j, i] - 1;

                if (rowCheck[rowIndex] || colCheck[colIndex])
                {
                    return false; 
                }

                rowCheck[rowIndex] = true;
                colCheck[colIndex] = true;
            }
        }

        for (int row = 0; row < size; row += n)
        {
            for (int col = 0; col < size; col += n)
            {
                bool[] squareCheck = new bool[size];

                for (int i = row; i < row + n; i++)
                {
                    for (int j = col; j < col + n; j++)
                    {
                        int squareIndex = sudoku[i, j] - 1;

                        if (squareCheck[squareIndex])
                        {
                            return false; 
                        }

                        squareCheck[squareIndex] = true;
                    }
                }
            }
        }

        return true; 
    }
}