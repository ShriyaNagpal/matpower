function [MVAbase, bus, gen, branch, success, et] = rundcpf(casename, mpopt, fname, solvedcase)
%RUNDCPF  Runs a DC power flow.
%
%   [baseMVA, bus, gen, branch, success, et] = ...
%           rundcpf(casename, mpopt, fname, solvedcase)
%
%   Runs a DC power flow where casename is the name of
%   the m-file (without the .m extension) containing the power flow data,
%   and mpopt is a MATPOWER options vector (see 'help mpoption' for details).
%   Uses default options if 2nd parameter is not given, and 'case9' if 1st
%   parameter is not given. The results may optionally be printed to a file
%   (appended if the file exists) whose name is given in fname (in addition
%   to printing to STDOUT). Optionally returns the final values of baseMVA,
%   bus, gen, branch, success, and et. If a name is given in solvedcase, the
%   solved case will be written to a case file in MATPOWER format with the
%   specified name with a '.m' extension added.

%   MATPOWER
%   $Id$
%   by Ray Zimmerman, PSERC Cornell
%   Copyright (c) 1996-2003 by Power System Engineering Research Center (PSERC)
%   See http://www.pserc.cornell.edu/ for more info.

%% default arguments
if nargin < 4
	solvedcase = '';				%% don't save solved case
	if nargin < 3
		fname = '';					%% don't print results to a file
		if nargin < 2
			mpopt = mpoption;		%% use default options
			if nargin < 1
				casename = 'case9';	%% default data file is 'case9.m'
			end
		end
	end
end

mpopt = mpoption(mpopt, 'PF_DC', 1);
[baseMVA, bus, gen, branch, success, et] = runpf(casename, mpopt, fname, solvedcase);

%% this is just to prevent it from printing baseMVA
%% when called with no output arguments
if nargout, MVAbase = baseMVA; end

return;
