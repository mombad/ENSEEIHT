Require Import Naturelle.
Section Session1_2019_Logique_Exercice_2.

Variable A B : Prop.

Theorem Exercice_2_Naturelle : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.
I_imp H4.
E_ou A (~A).
TE.
I_imp H1.
E_ou (~A) B.
Hyp H4.
I_imp H2.
I_ou_g.
Hyp H2.
I_imp H5.
I_ou_d.
I_et.
Hyp H1.
Hyp H5.
I_imp H6.
I_ou_g.
Hyp H6.
Qed.

Theorem Exercice_2_Coq : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.
intros.
absurd.

Qed.

End Session1_2019_Logique_Exercice_2.
