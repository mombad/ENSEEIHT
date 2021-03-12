with Text_IO
use Text_IO
with Ada.Integer_Text_IO
use Ada.Integer_Text_IO

--Ce programme simule fonctionnement d'un drone se déplaçant sur l'axe vertical pour des valeurs d'altitude comprises entre 0 et 5. Le drone doit d'abord démarrer avant de pouvoir se déplacer. La commande du drone se fait par l'utilisateur au moyen d'un menu.


procedure drone is
	Altitude: Integer
	lettre_saisie: Character
	Drone_Démarré: Integer

begin
	Altitude=0;
	Drone_Démarré=0;
	lettre_saisie=a;
	while lettre_saisie!=q:
		Put("Altitude :",Altitude);
		Put("Que faire ?");
		Put("	d -- Démarrer");
		Put("	m -- Monter");
		Put("	s -- Descendre");
		Put("	q -- Quitter");
		Put("Votre choix : _");
		Get(lettre_saisie);
		if Drone_Démarré=0 then 
			if lettre_saisie=d then
				Drone_Démarré=1
			else :
				Put("Le drone est éteint")
		end if
		if lettre_saisie=m:
			if Altitude<5 then: 
				Altitude=Altitude+1
			else:


