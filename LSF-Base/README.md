# LSF-Base

The LSF Base API allows for querying of host information including load, model and type, the number of Core, Cpu's, memory etc.  You can also launch remote tasks using LSF Baes task launching mechanisms from one architecture or operating system to the next.  This remote execution engine allows the launch of remote process to be executed on the correct hardware based upon LSF resource requirements.

## Release Information

* LSF-Base Perl Module for LSF
* Supporting LSF Release: 10.1
* Module Version: 1.01
* Publication date: 21 October 2013
* Last modified: 12 October 2022

## Contents
 
* Overview
* Installation
* Release Notes
* Community Contribution Requirements
* Copyright

## Overview

This library allows you to call the LSF APIs from Perl. The wrapper is created by using xsubpp.

This is an IBM Platform Computing fork of the original [LSF-Base-0.07](http://search.cpan.org/~lsfisv/).

IBM Platform Computing will provide formal support for this software to entitled clients via the normal IBM support channels.

## Installation

Before compiling the library, set LSF environment variables.

To compile and install the library, go to the source directory and type:

`$ perl Makefile.PL`
  
`$ make`
  
`$ sudo make install`

Note: If you are using perl 5.36 or upper, remove following 3 lines from Base.xs:
```
 #ifndef PL_errgv
 #define PL_errgv errgv
 #endif
```

## Release Notes

### Release 1.01 - 27/11/2013:
  * IBM Platform Computing refreshed LSF-Base-0.07 and provides formal support.
  * Tested with LSF 9.1.2 on Linux 2.6.

### Release 0.07 - 6/13/2008:
  * Exported the element nRes in LSF::Base::lsInfoPtr.
  * Added the document for the APIs, which can be viewed with perldoc.

### Release 0.06 - 4/29/2008:
  * Based on Version 0.05, some enhancements for APIs were added to support 
  * LSF 7.0 Update 2. All the APIs have been tested in test.pl on Linux 2.6 and Solaris 10(X86_64) by Perl 5.8.0.

### Release 0.05 - 3/29/2001:
  * Fixed a problem with version 0.04.

### Release 0.04 - 3/28/2001
  * Updated for LSF 4.0/4.1. Added support for other operating systems. Works with Compaq Alpha, Linux, AIX and Solaris. 

### Release 0.03 - 6/01/2000:
  * Synced version with LSF::Batch. Added new Makefile.PL. Fixed bugs.

### Release 0.01 - 12/21/1999:
  * First public release. Some functions were not totally debugged and not completely tested.

## Community Contribution Requirements

Community contributions to this repository must follow the [IBM Developer's Certificate of Origin (DCO)](https://github.com/IBMSpectrumComputing/perlAPI/blob/master/LSF-Base/IBMDCO.md) process and only through GitHub Pull Requests:

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
