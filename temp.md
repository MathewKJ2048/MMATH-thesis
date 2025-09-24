# Translating Signatures:

- A signature is a set, and fields of signatures are relations, i.e. subsets of the cartesian-cross product

```
sig A
{

}
sig B
{
	F : A
}
// Here, A and B are sets, and F is a subset of B cross A
```

- There are four multiplicities: one (==1), lone (<=1), some (>=1), set (any number)

- For the set multiplicity, no additional constraints are required on F

- For the one multiplicity, for all b in B, exists exactly one a in A such that (b,a) in F

- For lone multiplicity, for all b in B, exists exactly 0 or 1 a in A such that (b,a) in F

- For some multiplicity, for all b in B, exists a in A such that (b,a) in F

- When translating to TLA+, the output is used to determine whether the thing exists or does not


## TLA+ basics:

- TLA+ has specs, models are built from specs
- Specs are declarative, with an Init and Next as initial predicate and next-state relation
- Deadlocks happen when the model is run and halts
- By default, oe expects it not to halt


## Translation:

```
sig A
{

}
sig B
{
	F : lone A
}
```

