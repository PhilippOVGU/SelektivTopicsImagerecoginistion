function Classes=Crossvalidation10fold()

% wirf mich und alles andere in den ordner mit den ganzen unterordnern für die verschiedenen
% bildklassen


%ergebniss für jede klasse wird in Classes.CorrectAsw als % des anteils der
%richtigen klassifiziertungen



load('klassennamen.mat')
startpoint(1,1)=0;
% erstell der startpunkte der subsets indices für alle klassen 
for k=1:length(Classes.Size)
    for j=1:10
        if j==1
            startpoint(k,j)=1;
        else
            
            diff=floor(Classes.Size(k)/10);
            startpoint(k,j)=startpoint(k,j-1)+diff;
        end
    end
end

%erstell der endpunkte der subsets indices für alle klassen 
for k=1:length(Classes.Size)
    for j=1:10
        if j<10
            endpoints(k,j)=startpoint(k,j+1)-1;
        else
            endpoints(k,j)=(Classes.Size(k));
        end
    end
end


%% creating Trainingdata

TrainingData.ClassName=Classes.ClassName;
TestData.ClassName=Classes.ClassName;


% interation über alle klassen und jeweils über 10 subsets
for k=1:length(Classes.ClassName)
   
    
    
    richtig=0;
    for subset=1:10
        switch subset
            case 1
                TrainingData.Picturs=startpoint(k,2):endpoints(k,10);
                TestData.Picturs=startpoint(k,1):endpoints(k,1);
            case 2
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,1),startpoint(k,3):endpoints(k,10));
                TestData.Picturs=startpoint(k,2):endpoints(k,2);
            case 3
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,2),startpoint(k,4):endpoints(k,10));
                TestData.Picturs=startpoint(k,3):endpoints(k,3);
            case 4
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,3),startpoint(k,5):endpoints(k,10));
                TestData.Picturs=startpoint(k,4):endpoints(k,4);
            case 5
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,4),startpoint(k,6):endpoints(k,10));
                TestData.Picturs=startpoint(k,5):endpoints(k,5);
            case 6
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,5),startpoint(k,7):endpoints(k,10));
                TestData.Picturs=startpoint(k,6):endpoints(k,6);
            case 7
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,6),startpoint(k,8):endpoints(k,10));
                TestData.Picturs=startpoint(k,7):endpoints(k,7);
            case 8
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,7),startpoint(k,9):endpoints(k,10));
                TestData.Picturs=startpoint(k,8):endpoints(k,8);
            case 9
                TrainingData.Picturs=horzcat(startpoint(k,1):endpoints(k,8),startpoint(k,10):endpoints(k,10));
                TestData.Picturs=startpoint(k,9):endpoints(k,9);
                
            case 10
                TrainingData.Picturs=startpoint(k,1):endpoints(k,9);
                TestData.Picturs=startpoint(k,10):endpoints(k,10);
        end
        
        
        % To do --> Feed TrainingData.Picturs in learning algorithm for
        % Classifier --> TrainingData.Picturs sind zur zeit nur nummern
        % aber wenn man die klasse weiß und die nummer lässt sich der name
        % des bildes später recht leicht erzeugen da die ja alle
        % nummerierte namen haben
        
        
        % Hier würden wir dann später die Trainingsdaten in
        % Learnalgorithmus füttern
        
        % Example for Testing with Stupid Classifier:
        
        for j=1:length(TestData.Picturs)
            
            AnswerClass=Stupidclasserfier(Classes.ClassName);
%              AnswerClass=Cleverly_Stupidclasserfier(TestData.Picturs(j));
            
            if strcmp(AnswerClass,Classes.ClassName(k))
                richtig=richtig+1;
            end
            
        end
        
%         Subsetpercetage=richtig/length(TestData.Picturs);  % correct
%         percantage for this subset
        
        
        
        
        
        
    end
    
    Classes.CorrectAsw(k)=richtig/(Classes.Size(k)); % correct percentage for all subsets
end



end