class Target < ISM::Software

    def build
        super

        makeSource( arguments:  "prefix=/usr",
                    path:       buildDirectoryPath)
    end

    def build32Bits

        makeSource( arguments:  "clean",
                    path:       buildDirectoryPath)

        makeSource( arguments:      "prefix=/usr",
                    path:           buildDirectoryPath,
                    environment:    {"CC" => "gcc -m32"})
    end

    def buildx32Bits

        makeSource( arguments:  "clean",
                    path:       buildDirectoryPath)

        makeSource( arguments:      "prefix=/usr",
                    path:           buildDirectoryPath,
                    environment:    {"CC" => "gcc -mx32"})
    end

    def prepareInstallation
        super

        makeSource( arguments:  "prefix=/usr DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libzstd.a")

        if option("32Bits")
            build32Bits
            prepareInstallation32Bits
        end

        if option("x32Bits")
            buildx32Bits
            prepareInstallationx32Bits
        end
    end

    def prepareInstallation32Bits

        makeDirectory("#{buildDirectoryPath}/32Bits")

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr")

        makeSource( arguments:   "prefix=/usr DESTDIR=#{buildDirectoryPath}/32Bits install",
                    path: buildDirectoryPath)

        copyDirectory(  "#{buildDirectoryPath}/32Bits/usr/lib",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32")

        fileReplaceText(path:       "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/pkgconfig/libzstd.pc",
                        text:       "libdir=/lib64",
                        newText:    "libdir=/lib32")
    end

    def prepareInstallationx32Bits

        makeDirectory("#{buildDirectoryPath}/x32Bits")

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr")

        makeSource( arguments:  "prefix=/usr DESTDIR=#{buildDirectoryPath}/x32Bits install",
                    path:       buildDirectoryPath)

        copyDirectory(  "#{buildDirectoryPath}/x32Bits/usr/lib",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32")

        fileReplaceText(path:       "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/pkgconfig/libzstd.pc",
                        text:       "libdir=/lib64",
                        newText:    "libdir=/libx32")
    end

end
