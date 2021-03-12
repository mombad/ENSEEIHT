function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)
n=length(rho);
moy = inf;
for i=1:parametres(3)
    indices=randperm(n,2);
    [rho_F,theta_F] = estimation_F(rho(indices),theta(indices));
    
    Ecart=abs(rho-rho_F*cos(theta-theta_F));
    
    droites_conformes=Ecart<parametres(1);
        
    
    if sum(droites_conformes)>parametres(2)*n
        
        [rho_F_conf,theta_F_conf,moy_conf] = estimation_F(rho(droites_conformes),theta(droites_conformes));
        
        if moy_conf < moy
            rho_F_1 = rho_F_conf;
            theta_F_1 = theta_F_conf;
            
        end
    
    end
end
        