function [f]=calcul_frequences(texte,alphabet)
Lt=length(texte);
f=zeros(1,length(alphabet));
La=length(alphabet);
for i=1:La
    condition=texte==alphabet(i);
    f(i)=sum(condition)/Lt;
end
