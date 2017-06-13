import java.awt.Color;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.util.ArrayList;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.LineBorder;

public class Main {

	char[] target = "solvethislongstring".toCharArray();

	int popSize = 100;
	int generation = 1;
	double mutationRate = 0.05;
	int targetSize = target.length;
	static boolean done = false;
	JLabel jlabel;

	char[][] population = new char[popSize][targetSize];
	char[][] nextPopulation = new char[popSize][targetSize];
	int[] fitness = new int[popSize];
	Random rand;
	ArrayList<char[]> weightedPop;

	void run() {
		System.out.println("Generation " + generation);
		// Assigns a fitness value to each element

		calculateFitness();
		population = nextPopulation;

		if (!done) {
			crossOver();
		}

//		for (int i = 0; i < popSize; i++) {
//			for (int j = 0; j < targetSize; j++) {
//				System.out.print(population[i][j]);
//			}
//			System.out.print(" Fitness " + fitness[i]);
//			System.out.println();
//		}

		check();

		generation++;

	}

	void check() {

		boolean found = false;
		
		String str = "";

		for (int i = 0; i < bestChar.length; i++) {
			str += bestChar[i];
		}
		
		String str2 = "";

		for (int i = 0; i < target.length; i++) {
			str2 += target[i];
		}
		
		if(str2.equals(str)) {
			found = true;
		}
		

		if (found) {
			System.out.println("Found in " + generation + " generations");
			jlabel.setText(str);
			done = true;
		}
	}

	void createStartingPopulation() {
		for (int i = 0; i < popSize; i++) {
			for (int j = 0; j < targetSize; j++) {
				population[i][j] = (char) (rand.nextInt(25) + 97);
			}
		}

	}

	void crossOver() {

		// System.out.println(weightedPop.size());
		for (int i = 0; i < popSize; i++) {

			char[] parent1 = weightedPop.get(rand.nextInt(weightedPop.size()));
			char[] parent2 = weightedPop.get(rand.nextInt(weightedPop.size()));
			char[] child = new char[targetSize];

			for (int j = 0; j < targetSize; j++) {

				if (j < 2) {
					child[j] = parent1[j];
				} else {
					child[j] = parent2[j];
				}

				// if (rand.nextInt(2) == 0) {
				// child[j] = parent1[j];
				// } else {
				// child[j] = parent2[j];
				// }

				if (rand.nextInt(1000) <= mutationRate * 1000) {
					child[j] = (char) (rand.nextInt(25) + 97);
				}
			}
			nextPopulation[i] = child;
		}
	}

	int best = 0;
	char[] bestChar;

	void calculateFitness() {

		for (int i = 0; i < fitness.length; i++) {
			fitness[i] = 1;
		}

		int tempFitness = 1;
		for (int i = 0; i < popSize; i++) {
			tempFitness = 1;
			for (int j = 0; j < targetSize; j++) {

				if (population[i][j] == target[j]) {
					tempFitness*=2;

				}
				if (tempFitness > best) {
					best = tempFitness;
					bestChar = population[i];
				}
			}

			fitness[i] = tempFitness;
		}

		String str = "";

		for (int i = 0; i < population[0].length; i++) {
			str += population[0][i];
		}

		jlabel.setText(str);
		System.out.println();

		weightedPop = new ArrayList<char[]>();
		for (int i = 0; i < fitness.length; i++) {
			for (int j = 0; j < fitness[i]; j++) {
				weightedPop.add(population[i]);
			}
		}

	}

	public static void main(String[] args) {

		Main main = new Main();

		JFrame frame = new JFrame();
		frame.setLayout(new GridBagLayout());
		JPanel panel = new JPanel();
		main.jlabel = new JLabel("");
		main.jlabel.setFont(new Font("Ariel", 1, 20));
		panel.add(main.jlabel);
		frame.add(panel, new GridBagConstraints());
		frame.setSize(600, 600);
		frame.setLocationRelativeTo(null);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

		main.rand = new Random();
		main.createStartingPopulation();
		while (!done) {
			main.run();
		}

	}

}
