class Target < ISM::Software

    def prepare
        super

        fileDeleteLine("#{buildDirectoryPath}/install.sh",162)
        fileDeleteLine("#{buildDirectoryPath}/install.sh",162)
        fileDeleteLine("#{buildDirectoryPath}/install.sh",162)

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}CPP/7zip/Common/StreamObjects.cpp",
                                    text:       "return E_FAIL;",
                                    newText:    "if(_buffer == nullptr || _size == _pos) return E_FAIL;\nreturn E_FAIL;",
                                    lineNumber: 161)
    end

    def build
        super

        makeSource( arguments:  "all3",
                    path:       buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DEST_DIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} DEST_HOME=/usr DEST_MAN=/usr/share/man DEST_SHARE_DOC=/usr/share/doc/p7zip-17.04 install",
                    path:       buildDirectoryPath)
    end

end
