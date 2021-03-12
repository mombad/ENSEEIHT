function [selection_frequences,selection_alphabet]=selection(frequences,alphabet)
condition=frequences>0;
selection_frequences=frequences(condition);
selection_alphabet=alphabet(condition);