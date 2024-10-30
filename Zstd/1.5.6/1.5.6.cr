class Target < ISM::Software

    def build
        super

        makeSource( arguments:  "prefix=/usr",
                    path:       buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "prefix=/usr DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libzstd.a")
    end

end
