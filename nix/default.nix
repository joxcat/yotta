{ pkgs ? import <nixpkgs> {}
, pythonPackages ? pkgs.python38.pkgs
}:

let
  yottaSrc = pkgs.fetchgit {
    url = "https://github.com/joxcat/yotta.git";
    rev = "82d854b43d391abb5a006b05e7beffe7d0d6ffbf";
    sha256 = "sha256-xvMVw0aD8qLkwkT63u2s5QDecKY5DAQdGUw/0jF0DMY=";
  };
  pyPak = pythonPackages;
  jsonpointer = pyPak.buildPythonPackage rec {
    pname = "jsonpointer";
    version = "1.14";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-xoGvgjVFxzG3s4rt1dTu5MXv+HvA8l4P8lREpBierE0=";
    };
  };
  hgapi = pyPak.buildPythonPackage rec {
    pname = "hgapi";
    version = "1.7.4";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-Cx8gpqjO/p6fcrFKCCO3q9vIjRnN+BUhGEkGfZrCfrw=";
    };
    doCheck = false;
  };
  colorama = pyPak.buildPythonPackage rec {
    pname = "colorama";
    version = "0.3.9";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-SOsi9PhGGx31c0oHS1cEJDD7BuHWG9HhGweMD+bXofE=";
    };
  }; 
  jsonschema = pyPak.buildPythonPackage rec {
    pname = "jsonschema";
    version = "2.6.0";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-b/XzGAhwg2yuQPBvoQQZ9VcggXXxOte8Jsqne+sfbgI=";
    };
    propagatedBuildInputs = [ pyPak.vcversioner ];
    doCheck = false;
  };
  # cryptography = pyPak.buildPythonPackage rec {
  #   pname = "cryptography";
  #   version = "2.9.2";
  #   src = pyPak.fetchPypi {
  #     inherit pname version;
  #     sha256 = "sha256-oMMCcvtN3aX1/8EInXQFt6cbCw9RmTy05du0WQsvwik=";
  #   };
  #   propagatedBuildInputs = [ pyPak.cffi pkgs.openssl pyPak.six ];
  #   doCheck = false;
  # };
  pygithub = pyPak.buildPythonPackage rec {
    pname = "PyGithub";
    version = "1.55";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-G7//k3IEf/PyHVzY4Hcg89v9r2Ri/K7Z2BX1KPG6coM=";
    };
    propagatedBuildInputs = (with pyPak; [
      pyjwt
      deprecated
      pynacl
      requests 
    ]);
    doCheck = false;
  };
  pyelftools = pyPak.buildPythonPackage rec {
    pname = "pyelftools";
    version = "0.23";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-/Feq3Qluj5ubA/GpV49nPuZF4VE6X/AZLvQ5536rId4=";
    };
    doCheck = false;
  };
  libusb-package = pyPak.buildPythonPackage rec {
    pname = "libusb-package";
    version = "1.0.26.0";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-wcgRtlMBoVTIu0OjrWbuSh2q/1E9g+t1367h8OCZhUg=";
    };
    propagatedBuildInputs = [ pyPak.setuptools_scm ];
    doCheck = false;
  };
  pyocd = pyPak.buildPythonPackage rec {
    pname = "pyocd";
    version = "0.34.1";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-Fpa2IEsLOQ8ylGI/5D6h+22j1pvrvE9IMIyhCtyM6qU=";
    };
    propagatedBuildInputs = (with pyPak; [
      intelhex
      typing-extensions
      six
      pylink-square
      colorama
      natsort
      pyelftools
      intervaltree
      capstone
      pyusb
      libusb-package
      cmsis-pack-manager
      prettytable
    ]);
  };
  # pyyaml = pyPak.buildPythonPackage rec {
  #   pname = "pyyaml";
  #   version = "5.4.1";
  #   src = pyPak.fetchPypi {
  #     inherit version;
  #     pname = "PyYAML";
  #     sha256 = "sha256-YHd0y7oocyv6gCtUuqdIQhX1MJkQVbtWLvvtWy8gpF4=";
  #   };
  # };
  project-generator-definitions = pyPak.buildPythonPackage rec {
    pname = "project-generator-definitions";
    version = "0.2.43";
    src = pyPak.fetchPypi {
      inherit version;
      pname = "project_generator_definitions";
      sha256 = "sha256-aADpiiTdvnvV4fD4fUIkZcE+FEqTVYW2u0yiXATkBZg=";
    };
    propagatedBuildInputs = [ pyPak.xmltodict pyPak.pyyaml ];
  };
  argparse = pyPak.buildPythonPackage rec {
    pname = "argparse";
    version = "1.4.0";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-YrCJpVvh2JSc0rx+DfC9254Cj678jDIDjMhIYq791uQ=";
    };
  };
  project-generator = pyPak.buildPythonPackage rec {
    pname = "project-generator";
    version = "0.8.17";
    src = pkgs.fetchzip {
      url = "https://files.pythonhosted.org/packages/source/p/project-generator/project_generator-0.8.17.zip";
      sha256 = "sha256-i6WBb5EK41qDhdAvXiKilSLIGqmhslkyrrsoFAFTxH4=";
    };
    propagatedBuildInputs = (with pyPak; [
      xmltodict
      project-generator-definitions
      jinja2
      argparse
      pyPak.pyyaml
    ]);
    postPatch = ''
      sed -i "s/argparse//g" requirements.txt
      sed -i "s/PyYAML/pyyaml>=6.0/g" requirements.txt
    '';
    doCheck = false;
  };
  valinor = pyPak.buildPythonPackage rec {
    pname = "valinor";
    version = "1.1.4";
    src = pyPak.fetchPypi {
      inherit pname version;
      sha256 = "sha256-NGG6XQwRKm7+z8d019H9YS6vXDYJ2+DrGPCsr02GE4Q=";
    };
    propagatedBuildInputs = (with pyPak; [
      colorama
      pyocd
      pyelftools
      project-generator
      pyPak.pyyaml
      jinja2
      xmltodict
      project-generator-definitions
      intelhex
      typing-extensions
      six
      pylink-square
      natsort
      intervaltree
      capstone
      pyusb
      libusb-package
      cmsis-pack-manager
      prettytable
      nose
    ]);
    postPatch = ''
      sed -i "s/pyOCD>=0.3,/pyocd/g" setup.py
      sed -i "s/Jinja2>=2.7.0,/Jinja2>=2.7.0/g" setup.py
      sed -i "s/pyyaml>=5.1,<6.0/pyyaml>=6.0/g" setup.py
    '';
  };
  mbed-test-wrapper = pyPak.buildPythonPackage rec {
    pname = "mbed-test-wrapper";
    version = "1.0.0";
    src = pyPak.fetchPypi {
      inherit version;
      pname = "mbed_test_wrapper";
      sha256 = "sha256-zwoYmC2ETE8AzXPDHSGOwjKHgLGhVEvXw7zKeWUFyPI=";
    };
  };
in pyPak.buildPythonPackage {
  pname = "yotta";
  version = "0.20.0";
  src = yottaSrc;
  propagatedBuildInputs = (with pyPak; [
    # NOTE: because of ZIP does not support timestamps before 1980
    pkgs.ensureNewerSourcesForZipFilesHook 
    py 
    pip
    setuptools 
    jsonpointer
    hgapi
    requests
    colorama
    jsonschema
    intelhex
    pygithub
    pathlib2
    valinor
    semantic-version
    pyjwt
    argcomplete
    jinja2
    mbed-test-wrapper
  ]);
  postPatch = ''
    sed -i "s/PyJWT>=1.0,<2.0/PyJWT>=2.0/g" setup.py
    sed -i "s/argcomplete>=0.8.0,<2.0/argcomplete>=2.0.0/g" setup.py
    sed -i "s/Jinja2>=2.7.0,<3/Jinja2>=2.7.0/g" setup.py
    sed -i "s/cryptography>=2.8,<3/cryptography>=2.8/g" setup.py
    sed -i "s/pathlib>=1.0.1,<1.1/pathlib2>=2.0/g" setup.py
  '';
  doCheck = false;
}
