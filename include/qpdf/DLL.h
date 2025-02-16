/* Copyright (c) 2005-2022 Jay Berkenbilt
 *
 * This file is part of qpdf.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Versions of qpdf prior to version 7 were released under the terms
 * of version 2.0 of the Artistic License. At your option, you may
 * continue to consider qpdf to be licensed under those terms. Please
 * see the manual for additional information.
 */

#ifndef QPDF_DLL_HH
#define QPDF_DLL_HH

/* The first version of qpdf to include the version constants is 10.6.0. */
#define QPDF_MAJOR_VERSION 10
#define QPDF_MINOR_VERSION 6
#define QPDF_PATCH_VERSION 0
#define QPDF_VERSION "10.6.0"

#if (defined _WIN32 || defined __CYGWIN__) && defined(DLL_EXPORT)
# define QPDF_DLL __declspec(dllexport)
# define QPDF_DLL_CLASS
#elif __GNUC__ >= 4
# define QPDF_DLL __attribute__ ((visibility ("default")))
# define QPDF_DLL_CLASS __attribute__ ((visibility ("default")))
#else
# define QPDF_DLL
# define QPDF_DLL_CLASS
#endif

#endif /* QPDF_DLL_HH */
