% Script runs all shear steps of the CNS test
names={'';'';'';''};
% % Originial geometry
%     % same start geometry
% 		% 01 CNL stage
%             % geometry
%             names{1}='Geometry.txt';
% 
%             % lab parameter file
%             names{2}='Input_labCNS01_CNL.txt';
% 
%             % rock parameter file
%             names{3}='Input_rock.txt';
% 
%             % result file
%             names{4}='ResultCNS01_CNL.txt';
% 
%             Calculations(names);
%             close all;
%             
%         % 02 0.25 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS02_0.25.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS02_0.25MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 03 1 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS03_1.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS03_1MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 04 2 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS04_2.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS04_2MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 05 4 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS05_4.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS05_4MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 06 8 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS06_8.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS06_8MPamm.txt';
%             Calculations(names);
%             close all;
        
        % 07 16 MPa/mm
%             names{1}='Geometry.txt';
%             names{2}='Input_labCNS07_16.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS07_16MPamm.txt';
%             Calculations(names);
%             close all;

    
    
    % new geometry
        % 01 CNL stage
            % geometry
            names{1}='Geometry.txt';

            % lab parameter file
            names{2}='Input_labCNS01_CNL.txt';

            % rock parameter file
            names{3}='Input_rock.txt';

            % result file
            names{4}='ResultCNS01_CNL.txt';

            Calculations(names);
            close all;
            
        % 02 0.25 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS02_0.25.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS02_0.25MPamm.txt';
            Calculations(names);
            close all;
        
        % 03 1 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS03_1.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS03_1MPamm.txt';
            Calculations(names);
            close all;
        
        % 04 2 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS04_2.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS04_2MPamm.txt';
            Calculations(names);
            close all;
        
        % 05 4 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS05_4.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS05_4MPamm.txt';
            Calculations(names);
            close all;
        
        % 06 8 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS06_8.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS06_8MPamm.txt';
            Calculations(names);
            close all;
        
        % 07 16 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS07_16.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS07_16MPamm.txt';
            Calculations(names);
            close all;





% % Geometry without edge
%     % same start geometry
% 		% 01 CNL stage
%             % geometry
%             names{1}='GeometryWithoutEdge.txt';
% 
%             % lab parameter file
%             names{2}='Input_labCNS01_CNL.txt';
% 
%             % rock parameter file
%             names{3}='Input_rock.txt';
% 
%             % result file
%             names{4}='ResultCNS01_CNL.txt';
% 
%             Calculations(names);
%             close all;
%             
%         % 02 0.25 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS02_0.25.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS02_0.25MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 03 1 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS03_1.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS03_1MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 04 2 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS04_2.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS04_2MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 05 4 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS05_4.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS05_4MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 06 8 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS06_8.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS06_8MPamm.txt';
%             Calculations(names);
%             close all;
%         
%         % 07 16 MPa/mm
%             names{1}='GeometryWithoutEdge.txt';
%             names{2}='Input_labCNS07_16.0.txt';
%             names{3}='Input_rock.txt';
%             names{4}='ResultCNS07_16MPamm.txt';
%             Calculations(names);
%             close all;
% 
%     
%     
    % new geometry
        % 01 CNL stage
            % geometry
            names{1}='GeometryWithoutEdge.txt';

            % lab parameter file
            names{2}='Input_labCNS01_CNL.txt';

            % rock parameter file
            names{3}='Input_rock.txt';

            % result file
            names{4}='ResultCNS01_CNL.txt';

            Calculations(names);
            close all;
            
        % 02 0.25 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS02_0.25.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS02_0.25MPamm.txt';
            Calculations(names);
            close all;
        
%         03 1 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS03_1.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS03_1MPamm.txt';
            Calculations(names);
            close all;
        
        % 04 2 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS04_2.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS04_2MPamm.txt';
            Calculations(names);
            close all;
        
        % 05 4 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS05_4.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS05_4MPamm.txt';
            Calculations(names);
            close all;
        
        % 06 8 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS06_8.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS06_8MPamm.txt';
            Calculations(names);
            close all;
        
        % 07 16 MPa/mm
            names{1}='Geometry_new.txt';
            names{2}='Input_labCNS07_16.0.txt';
            names{3}='Input_rock.txt';
            names{4}='ResultCNS07_16MPamm.txt';
            Calculations(names);
            close all;

    

