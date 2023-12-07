class Target < ISM::Software

    def build
        super

        makeSource(["prefix=/usr"],buildDirectoryPath)
    end

    def build32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        makeSource( ["prefix=/usr"],
                    path: buildDirectoryPath,
                    environment: {"CC" => "gcc -m32"})
    end

    def buildx32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        makeSource( ["prefix=/usr"],
                    path: buildDirectoryPath,
                    environment: {"CC" => "gcc -mx32"})
    end

    def prepareInstallation
        super

        makeSource(["prefix=/usr","DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libzstd.a")

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

        makeDirectory("#{buildDirectoryPath(false)}/32Bits")

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr")

        makeSource( ["prefix=/usr",
                    "DESTDIR=#{buildDirectoryPath(false)}/32Bits",
                    "install"],
                    path: buildDirectoryPath)

        copyDirectory(  "#{buildDirectoryPath(false)}/32Bits/usr/lib",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32")

        fileReplaceText("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/pkgconfig/libzstd.pc",
                        "libdir=/lib64",
                        "libdir=/lib32")
    end

    def prepareInstallationx32Bits

        makeDirectory("#{buildDirectoryPath(false)}/x32Bits")

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr")

        makeSource( ["prefix=/usr",
                    "DESTDIR=#{buildDirectoryPath(false)}/x32Bits",
                    "install"],
                    path: buildDirectoryPath)

        copyDirectory(  "#{buildDirectoryPath(false)}/x32Bits/usr/lib",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32")

        fileReplaceText("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/pkgconfig/libzstd.pc",
                        "libdir=/lib64",
                        "libdir=/libx32")
    end

end
