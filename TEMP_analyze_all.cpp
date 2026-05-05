// Mi headers
#include "$1/include/MiEvent.h" 

R__LOAD_LIBRARY($2/lib/libMiModule.so);

void analyze_$5()
{
    const int num_simu = $6; 
    string simu_data[num_simu] = {$7};
    
    for(int p = 0; p < num_simu; p++)
    {
        cout << endl;
        cout << "*********************************************" << endl;
        cout << "Simu name: " << simu_data[p].c_str() << endl;
        cout << "Num events: " << $4 * ($3 + 1) << endl;
        cout << endl << "EFFICIENCIES :" << endl;    

        int const sizeeps = 10;
        string epsilons[sizeeps] = {"_eps1", "_eps2", "_eps3", "_eps4", "_eps5", "_eps6", "_eps7", "_eps8", "_eps9", "_eps10"};

        for(int epsilon = 0; epsilon < sizeeps; epsilon++)
        {
            int full_N = 0;  
            for(int d = 0; d <= $3; d++)
            {
                string file_path = Form("./%s/%d/%s_$4%s.root", simu_data[p].c_str(), d, simu_data[p].c_str(), epsilons[epsilon].c_str());
                
                if (gSystem->AccessPathName(file_path.c_str())) {
                    cout << "File not found in folder: " << d << endl;
                    continue;
                }
    
                TFile* f = new TFile(file_path.c_str());
            	TTree* s = (TTree*) f->Get("Event");
            
            	MiEvent* Eve = new MiEvent();
            	s->SetBranchAddress("Eventdata", &Eve);
                
                int N = s->GetEntries();
                full_N += N;
                
                delete Eve;
                f->Close();
                delete f;    
            }
            cout << "eps" << epsilon + 1 << " = " << (100.0 * full_N) / ($4 * ($3 + 1)) << "% +- " << (100.0 * sqrt(double(full_N)) ) / ($4 * ($3 + 1)) << "%" << endl;
        }
        cout << "*********************************************" << endl;
        cout << endl;
    }
}