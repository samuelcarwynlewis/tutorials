import data.real.basic

-- 0017: practising conjunction
example (P Q R : Prop) : P ∧ Q → Q ∧ P :=
begin
  intro h,
  cases h with hp hq,
  split,
  exact hq,
  exact hp,
end

-- 0018: use compression techniques
example (P Q R : Prop): P ∧ Q → Q ∧ P :=
begin
  intro h,
  cases h with hP hQ,
  exact ⟨hQ, hP⟩,
end

-- 0025: practising forall
def non_decreasing (f : ℝ → ℝ) := ∀ x₁ x₂, x₁ ≤ x₂ → f x₁ ≤ f x₂

def non_increasing (f : ℝ → ℝ) := ∀ x₁ x₂, x₁ ≤ x₂ → f x₁ ≥ f x₂

example (f g : ℝ → ℝ) (hf : non_decreasing f) (hg : non_increasing g) : non_increasing (g ∘ f) :=
begin
  intros x y h,
  apply hg,
  apply hf,
  exact h,
end

-- 0026: practising disjunction
#check mul_eq_zero

example (x y : ℝ) : x^2 = y^2 → x = y ∨ x = -y :=
begin
  intros h,
  have H : (x + y)*(x - y) = 0,
  { calc (x + y)*(x - y) = x^2 - y^2 : by ring
                     ... = 0 : by linarith, },
  rw mul_eq_zero at H,
  cases H with Hp Hm,
  right,
  linarith,
  left,
  linarith,
end

-- 0031: practising exists
open function 
variables (f g : ℝ → ℝ)

example (h : surjective (g ∘ f)) : surjective g :=
begin
  sorry
end

/- Negation -/

-- understand as P → false; manipulate as any implication and use `exfalso` to change the goal to false. For a proof by contradiction, with goal P, `by_contradiction` adds ¬ P to the context and changes the goal to false.

example (n : ℤ) (h_even : even n) (h_not_even : ¬ even n) : 0 = 1 :=
begin
  exfalso,
  exact h_not_even h_even,
end

-- for proof by contrapositive, use `contrapose`. To push negations inside quantifiers, it's `push_neg`. The combination of the two  is so common it's abbreviated to `contrapose!`.

example (P Q : Prop) (h : ¬ Q → ¬ P) : P → Q :=
begin
  contrapose,
  exact h,
end

def even_fun (f : ℝ → ℝ) := ∀ x, f (-x) = f x

example : ¬ even_fun (λ x, 2*x) :=
begin
  unfold even_fun, -- Here unfolding is important because push_neg won't do it.
  push_neg,
  use 42,
  linarith,
end

-- Some exercises

-- 0046: use exfalso
example (P Q : Prop) (h₁ : P ∨ Q) (h₂ : ¬ (P ∧ Q)) : ¬ P ↔ Q :=
begin
  sorry
end

-- 0048: use contrapose
example (n : ℤ) : even (n^2) ↔ even n :=
begin
  sorry
end

-- 0053: use push_neg
example (x : ℝ) : (∀ ε > 0, x ≤ ε) → x ≤ 0 :=
begin
  sorry
end