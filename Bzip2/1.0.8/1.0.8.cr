class Target < ISM::Software

    def prepare
        super

        fileReplaceText("#{buildDirectoryPath}/Makefile",
                        "ln -s -f $(PREFIX)/bin/",
                        "ln -s -f ")
        fileReplaceText("#{buildDirectoryPath}/Makefile",
                        "$(PREFIX)/man",
                        "$(PREFIX)/share/man")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["clean"],
                    path: buildDirectoryPath)

        deleteFile("#{buildDirectoryPath}/libbz2.so.1.0")
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def build32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        fileReplaceText("#{buildDirectoryPath}/Makefile",
                        "CC=gcc",
                        "CC=gcc -m32")
        fileReplaceText("#{buildDirectoryPath}/Makefile-libbz2_so",
                        "CC=gcc",
                        "CC=gcc -m32")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["Makefile-libbz2.a"],
                    path: buildDirectoryPath)
    end

    def buildx32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        fileReplaceText("#{buildDirectoryPath}/Makefile",
                        "CC=gcc",
                        "CC=gcc -mx32")
        fileReplaceText("#{buildDirectoryPath}/Makefile-libbz2_so",
                        "CC=gcc",
                        "CC=gcc -mx32")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["Makefile-libbz2.a"],
                    path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["PREFIX=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr","install"],buildDirectoryPath)

        copyFile(   Dir["#{buildDirectoryPath}/libbz2.so.*"],
                    "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib")

        copyFile(   "#{buildDirectoryPath}/bzip2-shared",
                    "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bzip2")

        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/libbz2.a")

        if option("32Bits")
            build32Bits
            prepareInstallation32Bits

            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0",:symbolicLinkByOverwrite)
        end

        if option("x32Bits")
            buildx32Bits
            prepareInstallationx32Bits

            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0",:symbolicLinkByOverwrite)
        end

        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bzcat")
        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bunzip2")

        makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libbz2.so",:symbolicLink)
        makeLink("bzip2","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/bzcat",:symbolicLinkByOverwrite)
        makeLink("bzip2","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/bunzip2",:symbolicLinkByOverwrite)
    end

    def prepareInstallation32Bits

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.a",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.a")
    end

    def prepareInstallationx32Bits

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.a",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.a")
    end

    def install
        super

        if option("32Bits")

            runChmodCommand(["0755","/usr/lib32/libbz2.so.1.0.8"])
            runChmodCommand(["0644","/usr/lib32/libbz2.a"])
        end

        if option("x32Bits")

            runChmodCommand(["0755","/usr/libx32/libbz2.so.1.0.8"])
            runChmodCommand(["0644","/usr/libx32/libbz2.a"])
        end

        runLdconfigCommand
    end

end
