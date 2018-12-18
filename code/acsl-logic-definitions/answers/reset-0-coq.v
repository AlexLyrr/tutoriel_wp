Definition P_same_elems (Mint_0 : farray addr Z) (Mint_1 : farray addr Z)
    (a : addr) (b : Z) (e : Z) : Prop :=
    forall (i : Z), let a_1 := (shift_sint32 a i%Z) in ((b <= i)%Z) ->
      ((i < e)%Z) -> (((Mint_0.[ a_1 ]) = (Mint_1.[ a_1 ]))%Z).
Goal
  forall (i_1 i : Z), forall (t_1 t : farray addr Z), forall (a : addr),
    ((P_zeroed t a i_1%Z i%Z)) -> ((P_same_elems t_1 t a i_1%Z i%Z)) -> ((P_zeroed t_1 a i_1%Z i%Z)).
(* Notre preuve *)
Proof.
  intros b e.
  (* by induction on the distance between b and e *)
  induction e using Z_induction with (m := b) ; intros mem_l2 mem_l1 a Hz_l1 Hsame.
  (* base case : "empty" Axiom *)
  + apply A_A_all_zeros.Q_zeroed_empty ; assumption.
  + replace (e + 1) with (1 + e) in * ; try omega.
    (* we use the range axiom *)
    rewrite A_A_all_zeros.Q_zeroed_range in * ; intros Hinf.
    apply Hz_l1 in Hinf ; clear Hz_l1 ; inversion_clear Hinf as [Hlast Hothers].
    split.
    (* subrange Hsame *)
    - rewrite Hsame ; try assumption ; omega.
    (* induction hypotheses *)
    - apply IHe with (t := mem_l1) ; try assumption.
      * unfold P_same_elems ; intros ; apply Hsame ; omega.
Qed.
