# LSF-Batch

The LSF Batch API allows for controling, submitting, and querying of jobs, queues, host sand other LSF information directly through Perl.

## Release Information

* LSF-Batch Perl Module for LSF
* Supporting LSF Release: 10.1
* Module Version: 1.05
* Publication date: 21 October 2013
* Last modified: 22 May 2017

## Contents

* Overview
* Installation
* Release Notes
* Community Contribution
* Copyright

## Overview

This library allows you to call the LSF APIs from Perl. The wrapper is created by using xsubpp.

This is an IBM Spectrum Computing fork of the original [LSF-Batch-0.06 APIs](http://search.cpan.org/~lsfisv/).

IBM Spectrum Computing provides formal support for this software to entitled clients via the normal IBM support channels.

## Installation

Before compiling the library, set LSF environment variables.

To compile and install the library, go to the source directory and run the following commands:

`$ perl Makefile.PL`

`$ make`

`$ sudo make install`

## Release Notes

### Release 1.05 - 18/5/2017
  * Added the following 4 fields in LSF_Batch_jobInfo :
    - appResReq (BJOBS_RES_REQ_DISPLAY=full should be configured in lsb.params)
    - qResReq   (BJOBS_RES_REQ_DISPLAY=full should be configured in lsb.params)
    - combinedResReq
    - effectiveResReq

  * Added the following 1 field in LSF_Batch_submit :
    - app

### Release 1.04 - 15/3/2017
  * Fixed a bug, cannot read EVENT_JOB_MODIFY2

### Release 1.03 - 27/2/2017
  * Fixed a compilation error

### Release 1.02 - 6/1/2017
  * Added the following 4 LSF::Batch APIs :
    - $batch->bjobs_openjobinfo_req()
    - $batch->readjobinfo_cond()
    - $batch->pendreason_ex()
    - $batch->bjobs_psum()
  * Tested with LSF 10.1 on Linux 2.6.

### Release 1.01 - 27/11/2013
  * IBM Platform Computing refreshed LSF-Batch-0.06 and provides formal support.
  * Tested with LSF 9.1.2 on Linux 2.6.

### Release 0.06 - 6/13/2008
  * Added 10 new APIs. These APIs were tested in test.pl on linux2.6 and Solaris 10(X86_64) by Perl 5.8.0. Added test_launch.pl to test two special APIs: lsb_gethostlist and lsb_launch.
  * test.pl can be used as normal. test_launch.pl is used in test.pl.
  * Added the document for the APIs, which can be viewed with perldoc.

### Release 0.05 - 4/29/2008
  * Based on Version 0.05, some enhancements for APIs were added to support 
  * LSF 7.0 Update 2. All the APIs have been tested in test.pl on Linux 2.6 and Solaris 10(X86_64) by Perl 5.8.0.

### Release 0.04 - 4/13/2001
  * General improvements. Added support for lsb_geteventrec. 
  * Added a script to help generate XS code from LSF include files (makexs.pl)

### Release 0.03 - 6/01/2000
  * Library works on Solaris. Several bugs were fixed.

### Release 0.02 - 4/05/2000
  * Added README to the MANIFEST.

### Release 0.01 - 4/04/2000
  * First public release. Some functions were not totally debugged and not completely tested.

## Community Contribution Requirements

Community contributions to this repository must follow the [IBM Developer's Certificate of Origin (DCO)](https://github.com/IBMSpectrumComputing/perlAPI/blob/master/LSF-Batch/IBMDCO.md) process and only through GitHub Pull Requests:

 1. Contributor proposes new code to community.

 2. Contributor signs off on contributions 
    (i.e. attachs the DCO to ensure contributor is either the code 
    originator or has rights to publish. The template of the DCO is included in
    this package).
 
 3. IBM Spectrum LSF development reviews contribution to check for:
    i)  Applicability and relevancy of functional content 
    ii) Any obvious issues

 4. If accepted, posts contribution. If rejected, work goes back to contributor and is not merged.

## Copyright

(C) Copyright IBM Corporation 2013-2020

U.S. Government Users Restricted Rights - Use, duplication or disclosure 
restricted by GSA ADP Schedule Contract with IBM Corp.

IBM(R), the IBM logo and ibm.com(R) are trademarks of International Business Machines Corp., 
registered in many jurisdictions worldwide. Other product and service names might be trademarks 
of IBM or other companies. A current list of IBM trademarks is available on the Web at 
"Copyright and trademark information" at www.ibm.com/legal/copytrade.shtml.
