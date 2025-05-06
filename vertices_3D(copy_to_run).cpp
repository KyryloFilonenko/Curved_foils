// -*- coding: utf-8 -*-
// Mi headers
#include "/sps/nemo/scratch/kfilonen/Falaise/MiModule/include/MiEvent.h" 

R__LOAD_LIBRARY(/sps/nemo/scratch/kfilonen/Falaise/MiModule/lib/libMiModule.so);


void vertices_3D()
{
// const int num_simu = 8; 
//     string simu_data[num_simu] = {"mf_0nu_Se82_flat", "mf_2nu_Se82_flat", "mf_Bi214_flat", "mf_Tl208_flat", "mf_0nu_Se82_bent", "mf_2nu_Se82_bent", "mf_Bi214_bent", "mf_Tl208_bent"};
    const int num_simu = 1; 
    string simu_data[num_simu] = {"mf_0nu_Se82_bent"};

    TCanvas *c1 = new TCanvas("c1", "3D Graph", 800, 600);
    TGraph2D *g3d = new TGraph2D();

    vector<double> x, y, z;
    
    // for(int s = 0; s < 1; s++)
    for(int p = 0; p < num_simu; p++)
    {
        int pas_1 = 0;
        int pas_2 = 0;
        int pas_3 = 0;
        int pas_4 = 0;
        int pas_5 = 0;
    
        int full_N = 0;
    
        for(int d = 0; d <= 10; d++)
        // for(int d = 0; d <= 99; d++)
        {
            string file_path = Form("./%s/%d/%s_100000.root", simu_data[p].c_str(), d, simu_data[p].c_str());
            
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
            
            int n_calo;
            int n_calov;
            int n_rec = 0;
            int n_neg;
            double energy;
        
        	for(UInt_t i=0; i < N; i++)	// Loop over events
        	{
        		s->GetEntry(i);
                
                n_calov = 0;
                n_neg = 0;
                energy = 0;
                
                n_rec = Eve->getPTD()->getpartv()->size();
                
                for(int j = 0; j < n_rec; j++)
                {
                    n_calo = Eve->getPTD()->getpartv()->at(j).getcalohitv()->size();
                    for(int k = 0; k < n_calo; k++)
                    {
                        energy += Eve->getPTD()->getpartv()->at(j).getcalohitv()->at(k).getE();
                    }
                }

                n_calov = Eve->getCD()->getnoofcaloh();
                                                
                // if (n_calov == 2) pas_1++;
                // if (n_calov == 2 && n_rec == 2) pas_2++;
                // if (n_calov == 2 && n_rec == 2 && energy > 2000.0) pas_3++;
                // if (n_calov == 2 && n_rec == 2 && energy > 2700.0) pas_4++;
                
                if (n_calov == 2 && n_rec == 2 && energy > 2700.0 && energy < 3300.0)
                {
                    pas_5++;
                    for(int j = 0; j < n_rec; j++)
                    {
                        // SD bank
                        x.push_back(Eve->getSD()->getpartv()->at(j).getr()->getX());
                        y.push_back(Eve->getSD()->getpartv()->at(j).getr()->getY());
                        z.push_back(Eve->getSD()->getpartv()->at(j).getr()->getZ());
                        // cout << x1 << " " << y1 << " " << z1 << " " << simu_data[p] << endl;

                        // PTD bank
                        // for(int k = 0; k < Eve->getPTD()->getpartv()->at(j).getvertexv()->size(); k++)
                        // {
                        //     x.push_back(Eve->getPTD()->getpartv()->at(j).getvertexv()->at(k).getr()->getX());
                        //     y.push_back(Eve->getPTD()->getpartv()->at(j).getvertexv()->at(k).getr()->getY());
                        //     z.push_back(Eve->getPTD()->getpartv()->at(j).getvertexv()->at(k).getr()->getZ());
                        //     // cout << x << " " << y << " " << z << " " << simu_data[p] << " " << Eve->getPTD()->getpartv()->at(j).getvertexv()->at(k).getpos() << endl;
                        // }
                    }
                }
            }
        }
    }
    int n_points = x.size();

    for (int i = 0; i < n_points; ++i) {
        if (abs(x[i]) <= 1)
        {
            g3d->SetPoint(i, x[i], y[i], z[i]);
        }
    }

    // Настройки графика
    g3d->SetTitle("3D Points;X;Y;Z");
    g3d->SetMarkerStyle(20); // Круглые маркеры
    g3d->SetMarkerSize(0.01);
    g3d->SetMarkerColor(kRed);

    // Рисуем график
    // g3d->Draw("P0"); // "P0" — просто точки
    g3d->Draw();
    c1->Update();
    
    // Сохраняем в файл (можно также .png, .pdf и т.д.)
    c1->SaveAs("3d_graph.root");
    // TFile *f = new TFile("interactive_graph.root", "RECREATE");
    // c1->cd();
    // g3d->Draw("P0");
    // c1->Write();
    // f->Close();
}



