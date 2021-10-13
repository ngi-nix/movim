{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false, packageOverrides}:

let
  packages = {
    "cakephp/core" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-core-dcb38950fa3bd722856f923ea8e4657ffcac78a7";
        src = fetchurl {
          url = "https://api.github.com/repos/cakephp/core/zipball/dcb38950fa3bd722856f923ea8e4657ffcac78a7";
          sha256 = "0zwk1fbm36lpll5z9ajcm6qyk75ayyqrc4xq1n3isrzwqkxh4a5n";
        };
      };
    };
    "cakephp/database" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-database-b41ccd93717f690a78e7564c4308de01b58cec5f";
        src = fetchurl {
          url = "https://api.github.com/repos/cakephp/database/zipball/b41ccd93717f690a78e7564c4308de01b58cec5f";
          sha256 = "0dd022n77lznxspl5hvm3j4z485xndmrcf26i89yh1433fqzsx2y";
        };
      };
    };
    "cakephp/datasource" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-datasource-211d985dbd9d55e81b1725ecb40e9da2cd83da05";
        src = fetchurl {
          url = "https://api.github.com/repos/cakephp/datasource/zipball/211d985dbd9d55e81b1725ecb40e9da2cd83da05";
          sha256 = "19z05jbr1ryz9mqg7zl6vp9idkvq0l0mac8jn7vgd4wp6bpyl56q";
        };
      };
    };
    "cakephp/utility" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-utility-4259ae4154e639557af751ae719d58253a79282a";
        src = fetchurl {
          url = "https://api.github.com/repos/cakephp/utility/zipball/4259ae4154e639557af751ae719d58253a79282a";
          sha256 = "1i51gcza3nn5qfr9k4giifys98sbm8ipr1czpn3g6chkzbbh0wrn";
        };
      };
    };
    "cboden/ratchet" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cboden-ratchet-466a0ecc83209c75b76645eb823401b5c52e5f21";
        src = fetchurl {
          url = "https://api.github.com/repos/ratchetphp/Ratchet/zipball/466a0ecc83209c75b76645eb823401b5c52e5f21";
          sha256 = "0aw8z0x208m171v5bv2xn0lq5xkbqrcjf7mkc9xcw2l7c5baw69l";
        };
      };
    };
    "cocur/slugify" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cocur-slugify-3f1ffc300f164f23abe8b64ffb3f92d35cec8307";
        src = fetchurl {
          url = "https://api.github.com/repos/cocur/slugify/zipball/3f1ffc300f164f23abe8b64ffb3f92d35cec8307";
          sha256 = "0l4dl42gad4msda4s7cz4iq7z2ci3nbgwb6052d4gvmda79ci1vg";
        };
      };
    };
    "composer/ca-bundle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-ca-bundle-0b072d51c5a9c6f3412f7ea3ab043d6603cb2582";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/ca-bundle/zipball/0b072d51c5a9c6f3412f7ea3ab043d6603cb2582";
          sha256 = "1a252kccych7zdfrfirn88d8vqs863knnf6lnry72wgjgbk5wdpd";
        };
      };
    };
    "composer/package-versions-deprecated" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-package-versions-deprecated-b174585d1fe49ceed21928a945138948cb394600";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/package-versions-deprecated/zipball/b174585d1fe49ceed21928a945138948cb394600";
          sha256 = "0m5hd3wfaka53n51b9aavyifwc2bdyr3jwywpkmpyrlmmn67c8ax";
        };
      };
    };
    "defuse/php-encryption" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "defuse-php-encryption-77880488b9954b7884c25555c2a0ea9e7053f9d2";
        src = fetchurl {
          url = "https://api.github.com/repos/defuse/php-encryption/zipball/77880488b9954b7884c25555c2a0ea9e7053f9d2";
          sha256 = "1lcvpg56nw72cxyh6sga7fx94qw9l0l1y78z7y7ny3hgdniwhihx";
        };
      };
    };
    "dflydev/fig-cookies" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dflydev-fig-cookies-ea6934204b1b34ffdf5130dc7e0928d18ced2498";
        src = fetchurl {
          url = "https://api.github.com/repos/dflydev/dflydev-fig-cookies/zipball/ea6934204b1b34ffdf5130dc7e0928d18ced2498";
          sha256 = "0xsk551bvmmfxfj2vxvl76323qg369aihicsalmf5aggwvzvnv1h";
        };
      };
    };
    "doctrine/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-cache-331b4d5dbaeab3827976273e9356b3b453c300ce";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/cache/zipball/331b4d5dbaeab3827976273e9356b3b453c300ce";
          sha256 = "1ksr3460a5dpqgq5kgy2l7kdz7fairpvmip8nwaz9y833r5hnnyz";
        };
      };
    };
    "doctrine/dbal" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-dbal-96b0053775a544b4a6ab47654dac0621be8b4cf8";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/dbal/zipball/96b0053775a544b4a6ab47654dac0621be8b4cf8";
          sha256 = "1cn7vbb87hb1hlfvkfyygk6mgbdw97lcw6jgc3m5ay5nfg397c2i";
        };
      };
    };
    "doctrine/deprecations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-deprecations-9504165960a1f83cc1480e2be1dd0a0478561314";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/deprecations/zipball/9504165960a1f83cc1480e2be1dd0a0478561314";
          sha256 = "04kpbzk5iw86imspkg7dgs54xx877k9b5q0dfg2h119mlfkvxil6";
        };
      };
    };
    "doctrine/event-manager" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-event-manager-41370af6a30faa9dc0368c4a6814d596e81aba7f";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/event-manager/zipball/41370af6a30faa9dc0368c4a6814d596e81aba7f";
          sha256 = "0pn2aiwl4fvv6fcwar9alng2yrqy8bzc58n4bkp6y2jnpw5gp4m8";
        };
      };
    };
    "doctrine/inflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-inflector-9cf661f4eb38f7c881cac67c75ea9b00bf97b210";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/inflector/zipball/9cf661f4eb38f7c881cac67c75ea9b00bf97b210";
          sha256 = "0gkaw5aqkdppd7cz1n46kdms0bv8kzbnpjh75jnhv98p9fik7f24";
        };
      };
    };
    "embed/embed" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "embed-embed-2c0e112f7332597ec6a55174f2353e04859ba356";
        src = fetchurl {
          url = "https://api.github.com/repos/oscarotero/Embed/zipball/2c0e112f7332597ec6a55174f2353e04859ba356";
          sha256 = "1n6znjxkwjpq9lvn7v1mg9jsbrv96v1ms02lll54mhiqgncs4spi";
        };
      };
    };
    "evenement/evenement" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "evenement-evenement-531bfb9d15f8aa57454f5f0285b18bec903b8fb7";
        src = fetchurl {
          url = "https://api.github.com/repos/igorw/evenement/zipball/531bfb9d15f8aa57454f5f0285b18bec903b8fb7";
          sha256 = "02mi1lrga41caa25whr6sj9hmmlfjp10l0d0fq8kc3d4483pm9rr";
        };
      };
    };
    "ezyang/htmlpurifier" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ezyang-htmlpurifier-08e27c97e4c6ed02f37c5b2b20488046c8d90d75";
        src = fetchurl {
          url = "https://api.github.com/repos/ezyang/htmlpurifier/zipball/08e27c97e4c6ed02f37c5b2b20488046c8d90d75";
          sha256 = "0jna0hhd63w9bs39kxw4gid35jg9rg928lzk3rrcvalq9zv957fz";
        };
      };
    };
    "fabiang/sasl" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fabiang-sasl-1ea6a403f2f2eb6cea69881c10c4605d52121d89";
        src = fetchurl {
          url = "https://api.github.com/repos/fabiang/sasl/zipball/1ea6a403f2f2eb6cea69881c10c4605d52121d89";
          sha256 = "1z19b6hanj17b8ipk6agd04nv176hsh1ksv8kv6xd9yysa0jhgyn";
        };
      };
    };
    "guzzlehttp/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-psr7-1afdd860a2566ed3c2b0b4a3de6e23434a79ec85";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/psr7/zipball/1afdd860a2566ed3c2b0b4a3de6e23434a79ec85";
          sha256 = "192p1yb0x4wb1hsxvqaxxidal2hk9382siy6x5l9g3i5k5dc1nnh";
        };
      };
    };
    "illuminate/bus" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-bus-a222094903c473b6b0ade0b0b0e20b83ae1472b6";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/bus/zipball/a222094903c473b6b0ade0b0b0e20b83ae1472b6";
          sha256 = "107cn93yadvslgazf5sgcyfparbnw3whv5616cchldghpqzffsah";
        };
      };
    };
    "illuminate/collections" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-collections-edaf5ea6ffe63dcab1ac86ee9db9c65209f44813";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/collections/zipball/edaf5ea6ffe63dcab1ac86ee9db9c65209f44813";
          sha256 = "018v3vcqwpfxqh1k7nb9y8gfn9lajwfwcgvc3nz64blr9r46cc2p";
        };
      };
    };
    "illuminate/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-container-ef73feb5216ef97ab7023cf59c0c8dbbd5505a9d";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/container/zipball/ef73feb5216ef97ab7023cf59c0c8dbbd5505a9d";
          sha256 = "12vvgik9pdp24v8173dv2fkl2vwpr9m1rp9rrhm5c7scw5sjdmyd";
        };
      };
    };
    "illuminate/contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-contracts-ab4bb4ec3b36905ccf972c84f9aaa2bdd1153913";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/contracts/zipball/ab4bb4ec3b36905ccf972c84f9aaa2bdd1153913";
          sha256 = "02ws5cvdhdcc3as1lhsvm73n5s3ra7wyykbnj5zw2srl6nlkm356";
        };
      };
    };
    "illuminate/database" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-database-b8c1e5393e8c7f087a7f79158d04f314f00422d0";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/database/zipball/b8c1e5393e8c7f087a7f79158d04f314f00422d0";
          sha256 = "1i7cnl6scxarrm78zail32qpx8901by6vra7a6af9nc325jfxcbv";
        };
      };
    };
    "illuminate/events" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-events-b7f06cafb6c09581617f2ca05d69e9b159e5a35d";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/events/zipball/b7f06cafb6c09581617f2ca05d69e9b159e5a35d";
          sha256 = "083md4zmmjhls1cmwfjml3s3bq20h7amjah8vmfb3d261fn310w1";
        };
      };
    };
    "illuminate/macroable" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-macroable-300aa13c086f25116b5f3cde3ca54ff5c822fb05";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/macroable/zipball/300aa13c086f25116b5f3cde3ca54ff5c822fb05";
          sha256 = "1d8k148n8p2b22f1jkwl21pfgigm1qzwgvc64ar05fzka882x7iw";
        };
      };
    };
    "illuminate/pipeline" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-pipeline-23aeff5b26ae4aee3f370835c76bd0f4e93f71d2";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/pipeline/zipball/23aeff5b26ae4aee3f370835c76bd0f4e93f71d2";
          sha256 = "0hfviaxxw4jrya1gf57camvx463hk4h1cmr0h56d0wg4jbnssjhw";
        };
      };
    };
    "illuminate/support" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "illuminate-support-5346222c24bbc0da88af032053328dbebd1ab2d8";
        src = fetchurl {
          url = "https://api.github.com/repos/illuminate/support/zipball/5346222c24bbc0da88af032053328dbebd1ab2d8";
          sha256 = "18p1j97dh12sawgl5rbya5djkmgmbri9x0fvjy5hsjx9akgznz38";
        };
      };
    };
    "league/commonmark" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-commonmark-c4228d11e30d7493c6836d20872f9582d8ba6dcf";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/commonmark/zipball/c4228d11e30d7493c6836d20872f9582d8ba6dcf";
          sha256 = "0x18k1qmvskd5x1b3jkkmig6l734sxffj5xyfb82yrzgpw9lrld5";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-fd4380d6fc37626e2f799f29d91195040137eba9";
        src = fetchurl {
          url = "https://api.github.com/repos/Seldaek/monolog/zipball/fd4380d6fc37626e2f799f29d91195040137eba9";
          sha256 = "1k56si01sjl93mxq1pk599yqqqhldqz34qi73y5jaga0m9iq07wk";
        };
      };
    };
    "nesbot/carbon" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nesbot-carbon-f4655858a784988f880c1b8c7feabbf02dfdf045";
        src = fetchurl {
          url = "https://api.github.com/repos/briannesbitt/Carbon/zipball/f4655858a784988f880c1b8c7feabbf02dfdf045";
          sha256 = "18px9mynqabrhgss5nyhadncdcf7aq1mzbbyrxfqbvyv54zq4zjh";
        };
      };
    };
    "paragonie/random_compat" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "paragonie-random_compat-996434e5492cb4c3edcb9168db6fbb1359ef965a";
        src = fetchurl {
          url = "https://api.github.com/repos/paragonie/random_compat/zipball/996434e5492cb4c3edcb9168db6fbb1359ef965a";
          sha256 = "0ky7lal59dihf969r1k3pb96ql8zzdc5062jdbg69j6rj0scgkyx";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-8622567409010282b7aeebe4bb841fe98b58dcaf";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/container/zipball/8622567409010282b7aeebe4bb841fe98b58dcaf";
          sha256 = "0qfvyfp3mli776kb9zda5cpc8cazj3prk0bg0gm254kwxyfkfrwn";
        };
      };
    };
    "psr/http-message" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-message-f6561bf28d520154e4b0ec72be95418abe6d9363";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-message/zipball/f6561bf28d520154e4b0ec72be95418abe6d9363";
          sha256 = "195dd67hva9bmr52iadr4kyp2gw2f5l51lplfiay2pv6l9y4cf45";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-d49695b909c3b7628b6289db5479a1c204601f11";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/log/zipball/d49695b909c3b7628b6289db5479a1c204601f11";
          sha256 = "0sb0mq30dvmzdgsnqvw3xh4fb4bqjncx72kf8n622f94dd48amln";
        };
      };
    };
    "psr/simple-cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-simple-cache-408d5eafb83c57f6365a3ca330ff23aa4a5fa39b";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/simple-cache/zipball/408d5eafb83c57f6365a3ca330ff23aa4a5fa39b";
          sha256 = "1djgzclkamjxi9jy4m9ggfzgq1vqxaga2ip7l3cj88p7rwkzjxgw";
        };
      };
    };
    "rain/raintpl" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "rain-raintpl-edee683bf242f40cc75bee46a78759f6c1589dca";
        src = fetchurl {
          url = "https://api.github.com/repos/feulf/raintpl3/zipball/edee683bf242f40cc75bee46a78759f6c1589dca";
          sha256 = "0x4lsn63m0n8br8nvcqy9v361xfiidknmvcr4ask4dq6z1k70srb";
        };
      };
    };
    "ralouphie/getallheaders" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ralouphie-getallheaders-120b605dfeb996808c31b6477290a714d356e822";
        src = fetchurl {
          url = "https://api.github.com/repos/ralouphie/getallheaders/zipball/120b605dfeb996808c31b6477290a714d356e822";
          sha256 = "1bv7ndkkankrqlr2b4kw7qp3fl0dxi6bp26bnim6dnlhavd6a0gg";
        };
      };
    };
    "ratchet/pawl" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ratchet-pawl-89ec703c76dc893484a2a0ed44b48a37d445abd5";
        src = fetchurl {
          url = "https://api.github.com/repos/ratchetphp/Pawl/zipball/89ec703c76dc893484a2a0ed44b48a37d445abd5";
          sha256 = "0l10qa27hnaki8k3v9q5kwya9kivpsv5n5bby3737h8m2my2hr8g";
        };
      };
    };
    "ratchet/rfc6455" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ratchet-rfc6455-c8651c7938651c2d55f5d8c2422ac5e57a183341";
        src = fetchurl {
          url = "https://api.github.com/repos/ratchetphp/RFC6455/zipball/c8651c7938651c2d55f5d8c2422ac5e57a183341";
          sha256 = "1f0qlknq5j78845gfwfh812d8j3qp83967b8nygr07b517hbysbl";
        };
      };
    };
    "react/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-cache-4bf736a2cccec7298bdf745db77585966fc2ca7e";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/cache/zipball/4bf736a2cccec7298bdf745db77585966fc2ca7e";
          sha256 = "07l1gc5lvxspc2gwkwhz0f2al4y452f0n4fdc2g68whxmwm6a6j0";
        };
      };
    };
    "react/child-process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-child-process-a778f3fb828d68caf8a9ab6567fd8342a86f12fe";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/child-process/zipball/a778f3fb828d68caf8a9ab6567fd8342a86f12fe";
          sha256 = "0zh0ay990nspahqhwn02khi9lmjrgd9c7infq155xhzshq56rlsv";
        };
      };
    };
    "react/dns" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-dns-2a5a74ab751e53863b45fb87e1d3913884f88248";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/dns/zipball/2a5a74ab751e53863b45fb87e1d3913884f88248";
          sha256 = "0p00syq8lx6qivdkvppic7lniavz6vw7cjxf5ad52lzj4d43ryzs";
        };
      };
    };
    "react/event-loop" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-event-loop-be6dee480fc4692cec0504e65eb486e3be1aa6f2";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/event-loop/zipball/be6dee480fc4692cec0504e65eb486e3be1aa6f2";
          sha256 = "1g9ark4cvnkajy3390fr79xvvg1fvhzchrc00cwkf1x7hrcfcms3";
        };
      };
    };
    "react/http" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-http-8a0fd7c0aa74f0db3008b1e47ca86c613cbb040e";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/http/zipball/8a0fd7c0aa74f0db3008b1e47ca86c613cbb040e";
          sha256 = "0pfgcydl7j0i5gn4jbzwqi4k63qln9s4lax2zjs6xmnqa16kxi2i";
        };
      };
    };
    "react/promise" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-promise-f3cff96a19736714524ca0dd1d4130de73dbbbc4";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/promise/zipball/f3cff96a19736714524ca0dd1d4130de73dbbbc4";
          sha256 = "0wg9260q99z7sapsm43nhh1gl588z238aixjkp081x1h0c8j500m";
        };
      };
    };
    "react/promise-stream" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-promise-stream-6384d8b76cf7dcc44b0bf3343fb2b2928412d1fe";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/promise-stream/zipball/6384d8b76cf7dcc44b0bf3343fb2b2928412d1fe";
          sha256 = "0g4p8khnh2cjirl1d5zim2b14567vpi2ipadwxngay8fil3wh60y";
        };
      };
    };
    "react/promise-timer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-promise-timer-607dd79990e32fcb402cb0a176b4a4be12f97e7c";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/promise-timer/zipball/607dd79990e32fcb402cb0a176b4a4be12f97e7c";
          sha256 = "032l04rsjrhk7q7bnv4vjxfpp2szzhf50m38p05jyry3bjw5mh72";
        };
      };
    };
    "react/socket" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-socket-aa6e3f8ebcd6dec3ad1ee92a449b4cc341994001";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/socket/zipball/aa6e3f8ebcd6dec3ad1ee92a449b4cc341994001";
          sha256 = "0gdv1xy0rwbs3r5sxgg5lqyn8bjnpj5bwwvgljwwd2fjjflfqkqb";
        };
      };
    };
    "react/stream" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "react-stream-7a423506ee1903e89f1e08ec5f0ed430ff784ae9";
        src = fetchurl {
          url = "https://api.github.com/repos/reactphp/stream/zipball/7a423506ee1903e89f1e08ec5f0ed430ff784ae9";
          sha256 = "1vcn792785hg0991vz3fhdmwl5y47z4g7hvly04y03zmbc0qx0mf";
        };
      };
    };
    "respect/stringifier" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "respect-stringifier-e55af3c8aeaeaa2abb5fa47a58a8e9688cc23b59";
        src = fetchurl {
          url = "https://api.github.com/repos/Respect/Stringifier/zipball/e55af3c8aeaeaa2abb5fa47a58a8e9688cc23b59";
          sha256 = "051z27lchxk1s0c16c5vc6sdmxw4x4g02iacm54kvxbapdgh5yvg";
        };
      };
    };
    "respect/validation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "respect-validation-4c21a7ffc9a4915673cb2c2843963919e664e627";
        src = fetchurl {
          url = "https://api.github.com/repos/Respect/Validation/zipball/4c21a7ffc9a4915673cb2c2843963919e664e627";
          sha256 = "1k2mzmv2595579zncfc15fmgqvx3j4q1bbrc9sy0pi9cjrbygi3b";
        };
      };
    };
    "ringcentral/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ringcentral-psr7-360faaec4b563958b673fb52bbe94e37f14bc686";
        src = fetchurl {
          url = "https://api.github.com/repos/ringcentral/psr7/zipball/360faaec4b563958b673fb52bbe94e37f14bc686";
          sha256 = "1j59spmy83gyzc05wl2j92ly51d67bpvgd7nmxma8a8j8vrh063w";
        };
      };
    };
    "robmorgan/phinx" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "robmorgan-phinx-5a0146a74c1bc195d1f5da86afa3b68badf7d90e";
        src = fetchurl {
          url = "https://api.github.com/repos/cakephp/phinx/zipball/5a0146a74c1bc195d1f5da86afa3b68badf7d90e";
          sha256 = "1j5bf7iylngqkw2wz6qvswmr7ibs65g0vmxjldsszbaq2hqk6ikr";
        };
      };
    };
    "symfony/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-config-4268f3059c904c61636275182707f81645517a37";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/config/zipball/4268f3059c904c61636275182707f81645517a37";
          sha256 = "1izirgswwdmg6kp8akrijgc98221w97rwibrhiz89xlxx3990qyn";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-8b1008344647462ae6ec57559da166c2bfa5e16a";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/console/zipball/8b1008344647462ae6ec57559da166c2bfa5e16a";
          sha256 = "1gia4h03rs751qyik3g1k8r9g4n6xc6z60f4f9lh1j11bwyx4mcd";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-5f38c8804a9e97d23e0c8d63341088cd8a22d627";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/deprecation-contracts/zipball/5f38c8804a9e97d23e0c8d63341088cd8a22d627";
          sha256 = "11k6a8v9b6p0j788fgykq6s55baba29lg37fwvmn4igxxkfwmbp3";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-343f4fe324383ca46792cae728a3b6e2f708fb32";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/filesystem/zipball/343f4fe324383ca46792cae728a3b6e2f708fb32";
          sha256 = "0a68w982cy4lqs1hz3y44n4dzsjbl1478x0dg5xmkbbszyiiwapp";
        };
      };
    };
    "symfony/http-foundation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-foundation-e36c8e5502b4f3f0190c675f1c1f1248a64f04e5";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-foundation/zipball/e36c8e5502b4f3f0190c675f1c1f1248a64f04e5";
          sha256 = "0h2v2kkk4svj5bf5hzinkw884f014ig23b32k79v6q0cag85xlmq";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-46cd95797e9df938fdd2b03693b5fca5e64b01ce";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-ctype/zipball/46cd95797e9df938fdd2b03693b5fca5e64b01ce";
          sha256 = "0z4iiznxxs4r72xs4irqqb6c0wnwpwf0hklwn2imls67haq330zn";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-16880ba9c5ebe3642d1995ab866db29270b36535";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/16880ba9c5ebe3642d1995ab866db29270b36535";
          sha256 = "0pb57756kvdxksqy2nndf8q7c91p2dzhysa52x2rbhba869760fv";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-8590a5f561694770bdcd3f9b5c69dde6945028e8";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/8590a5f561694770bdcd3f9b5c69dde6945028e8";
          sha256 = "1c60xin00q0d2gbyaiglxppn5hqwki616v5chzwyhlhf6aplwsh3";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-9174a3d80210dca8daa7f31fec659150bbeabfc6";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/9174a3d80210dca8daa7f31fec659150bbeabfc6";
          sha256 = "17bhba3093di6xgi8f0cnf3cdd7fnbyp9l76d9y33cym6213ayx1";
        };
      };
    };
    "symfony/polyfill-php73" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php73-fba8933c384d6476ab14fb7b8526e5287ca7e010";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php73/zipball/fba8933c384d6476ab14fb7b8526e5287ca7e010";
          sha256 = "0fc1d60iw8iar2zcvkzwdvx0whkbw8p6ll0cry39nbkklzw85n1h";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-1100343ed1a92e3a38f9ae122fc0eb21602547be";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php80/zipball/1100343ed1a92e3a38f9ae122fc0eb21602547be";
          sha256 = "0kwk2qgwswsmbfp1qx31ahw3lisgyivwhw5dycshr5v2iwwx3rhi";
        };
      };
    };
    "symfony/polyfill-php81" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php81-e66119f3de95efc359483f810c4c3e6436279436";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php81/zipball/e66119f3de95efc359483f810c4c3e6436279436";
          sha256 = "0hg340da7m0yipj2bj5hxhd3mqidz767ivg7w85r8vwz3mr9k1p3";
        };
      };
    };
    "symfony/routing" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-routing-be865017746fe869007d94220ad3f5297951811b";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/routing/zipball/be865017746fe869007d94220ad3f5297951811b";
          sha256 = "1pzfhvxq1idwfw6vpjfrywzr3w4j4h03vwjvqxpf43a9ccv17p31";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-f040a30e04b57fbcc9c6cbcf4dbaa96bd318b9bb";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/service-contracts/zipball/f040a30e04b57fbcc9c6cbcf4dbaa96bd318b9bb";
          sha256 = "1i573rmajc33a9nrgwgc4k3svg29yp9xv17gp133rd1i705hwv1y";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-8d224396e28d30f81969f083a58763b8b9ceb0a5";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/string/zipball/8d224396e28d30f81969f083a58763b8b9ceb0a5";
          sha256 = "13bv53s2s7fvk064yx2xa0f5p9jh0slxc2pnrzp7m6jnqha6mlcy";
        };
      };
    };
    "symfony/translation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-6e69f3551c1a3356cf6ea8d019bf039a0f8b6886";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation/zipball/6e69f3551c1a3356cf6ea8d019bf039a0f8b6886";
          sha256 = "0y6dzxs8cgag3dcnh18ywp72k1daj0jnrylnhxd6wzbrcx0k8hch";
        };
      };
    };
    "symfony/translation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-contracts-95c812666f3e91db75385749fe219c5e494c7f95";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation-contracts/zipball/95c812666f3e91db75385749fe219c5e494c7f95";
          sha256 = "073l1pbmwbkaviwwjq9ypb1w7dk366nn2vn1vancbal0zqk0zx7b";
        };
      };
    };
    "voku/portable-ascii" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "voku-portable-ascii-80953678b19901e5165c56752d087fc11526017c";
        src = fetchurl {
          url = "https://api.github.com/repos/voku/portable-ascii/zipball/80953678b19901e5165c56752d087fc11526017c";
          sha256 = "112sz1jl55l3qm3041ijyzxy7qbv0sa6535hx6sp7nk2c76wjq0d";
        };
      };
    };
  };
  devPackages = {};
in
composerEnv.buildPackage {
  inherit packages devPackages packageOverrides noDev;
  name = "movim-movim";
  src = ./.;
  executable = false;
  symlinkDependencies = false;
  meta = {};
}
