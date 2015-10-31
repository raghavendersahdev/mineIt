import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

import java.util.Random;

import weka.classifiers.*;
import weka.classifiers.bayes.BayesNet;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.lazy.IBk;
import weka.classifiers.rules.JRip;
import weka.classifiers.trees.J48;
public class Q5 {
	
	public static void ClassificationModel()
	{

		String inputData[] = new String[7];
		String rootDir = "/Users/omarabid/ownCloud/01 Fall 2015/CSE 6412 Data Mining/Assignments/2/Q5/";
		inputData[0] = "balance-scale.arff";
		inputData[1] = "ecoli.arff";
		inputData[2] = "glass.arff";
		inputData[3] = "ionosphere.arff";
		inputData[4] = "wine.arff";
		inputData[5] = "iris.arff";
		inputData[6] = "yeast.arff";
		

		 DataSource source;
		 Instances data;
		try {
			//
		    // Step 1: Get the instances
			//
			
 			//Moved to step 3
			
			
			 //
			 // Step 2: Set the options
			 //
			int count = 0;
			
	

		    
		    //som.setOptions(weka.core.Utils.splitOptions("-C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K \"weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0\""));
	
		    


		
			 //                //
			 // Step 3: Build the classifier
			 J48 j48 = new J48();;
			 JRip jrip = new JRip();
			 NaiveBayes naiveBayes = new NaiveBayes();
			 BayesNet bayesNet = new BayesNet();
			 IBk lazyClassifier = new IBk();
			 MultilayerPerceptron multilayerPerceptron = new MultilayerPerceptron();
			 j48.setOptions(optionsJ48);
			 jrip.setOptions(optionsJRip);
			 naiveBayes.setOptions(optionsNaiveBayes);
			 bayesNet.setOptions(optionsBayesNet);
			 lazyClassifier.setOptions(weka.core.Utils.splitOptions("-K 1 -W 0 -A \"weka.core.neighboursearch.LinearNNSearch -A \\\"weka.core.EuclideanDistance -R first-last\\\"\""));	 
			 multilayerPerceptron.setOptions(SOM);
			 
			 // Store all the classifier error rates.
			 double []acrossAllClassifierErrorRate = new double[inputData.length];
			 for (int i = 0; i<acrossAllClassifierErrorRate.length;i++)
				 acrossAllClassifierErrorRate[i] = 0;
			 
			 // -1 atm because yeast dataset isn't working!!
			 for (int i = 0; i <inputData.length;i++){
				 // Get the data first
				 source = new DataSource(rootDir + inputData[i]);
				data = source.getDataSet();
	     		 if (data.classIndex() == -1)
					   data.setClassIndex(data.numAttributes() - 1);
	     		 if (i == 4) // if it is the wine.arff one
	     			 data.setClassIndex(0);
	     		 // Build the classifier now!
				 j48.buildClassifier(data);
				 jrip.buildClassifier(data);
				 naiveBayes.buildClassifier(data);
				 bayesNet.buildClassifier(data);
				 lazyClassifier.buildClassifier(data);
				 multilayerPerceptron.buildClassifier(data);
				 
				 Evaluation j48Eval = new Evaluation(data);
				 Evaluation jripEval = new Evaluation(data);
				 Evaluation naiveBayesEval = new Evaluation(data);
				 Evaluation bayesNetEval = new Evaluation(data);
				 Evaluation lazyClassifierEval = new Evaluation(data);
				 Evaluation multilayerEval = new Evaluation(data);
				 j48Eval.crossValidateModel(j48, data, 10, new Random(1));
				 jripEval.crossValidateModel(jrip, data, 10, new Random(1));
				 naiveBayesEval.crossValidateModel(naiveBayes, data, 10, new Random(1));
				 bayesNetEval.crossValidateModel(bayesNet, data, 10, new Random(1));
				 multilayerEval.crossValidateModel(multilayerPerceptron, data, 10, new Random(1));
				 lazyClassifierEval.crossValidateModel(lazyClassifier, data, 10, new Random(1));
				 
				 System.out.println("Data Set: " + inputData[i]+" Misclassification rate:");
				 System.out.println("J48 "+ j48Eval.errorRate());
				 System.out.println("JRip "+ jripEval.errorRate());
				 System.out.println("NaiveBayes "+ naiveBayesEval.errorRate());
				 System.out.println("BayesNet "+ bayesNetEval.errorRate());
				 System.out.println("LazyClassifier "+ lazyClassifierEval.errorRate());
				 System.out.println("MultiLayer "+ multilayerEval.errorRate());
                 
				 acrossAllClassifierErrorRate[0] +=j48Eval.errorRate();
				 acrossAllClassifierErrorRate[1] +=jripEval.errorRate();
				 acrossAllClassifierErrorRate[2] +=naiveBayesEval.errorRate();
				 acrossAllClassifierErrorRate[3] +=bayesNetEval.errorRate();
				 acrossAllClassifierErrorRate[4] +=lazyClassifierEval.errorRate();
				 acrossAllClassifierErrorRate[5] += multilayerEval.errorRate();
						 
				 

			 
			 }
			 //Display Values
			 System.out.println("Average classification over all data sets...");
			 for (int i = 0; i<acrossAllClassifierErrorRate.length;i++){
				 acrossAllClassifierErrorRate[i] /=(double)(acrossAllClassifierErrorRate.length );
			     System.out.println(acrossAllClassifierErrorRate[i]);
			 }

			 
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		
		
	}
	
	public static void main  (String args[]) throws Exception{
		ClassificationModel();


	}

}
