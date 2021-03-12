Require Import Naturelle.
Section Session1_2019_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
I_imp H1.
I_imp H2.
E_imp B.
E_imp A.
Hyp H1.
E_et_g B.
Hyp H2.
E_et_d A.
Hyp H2.

Qed.

Theorem Exercice_1_Coq :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
intros.
cut B.
cut A.
Hyp H.
destruct H0 as (HA,HB).
Hyp HA.
destruct H0 as (HA,HB).
Hyp HB.
Qed.

End Session1_2019_Logique_Exercice_1.

